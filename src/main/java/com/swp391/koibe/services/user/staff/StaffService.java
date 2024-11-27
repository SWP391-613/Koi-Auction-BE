package com.swp391.koibe.services.user.staff;

import com.swp391.koibe.dtos.StaffRegisterDTO;
import com.swp391.koibe.dtos.UserDTO;
import com.swp391.koibe.enums.UserRole;
import com.swp391.koibe.enums.UserStatus;
import com.swp391.koibe.exceptions.PermissionDeniedException;
import com.swp391.koibe.exceptions.StaffNotFoundException;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.metadata.PaginationMeta;
import com.swp391.koibe.models.Role;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.RoleRepository;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.responses.StaffResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.utils.DTOConverter;
import com.swp391.koibe.utils.DateTimeUtils;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class StaffService implements IStaffService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final DTOConverter dtoConverter;

    @Override
    public PageResponse<StaffResponse> getAllStaffs(Pageable pageable) {
        Page<User> staffs = userRepository.findAllStaff(pageable);

        List<StaffResponse> staffResponses = staffs.getContent().stream()
            .map(dtoConverter::toStaffResponse)
            .toList();

        return PageResponse.<StaffResponse>pageBuilder()
            .message("Get all staffs successfully")
            .statusCode(200)
            .isSuccess(true)
            .data(staffResponses)
            .pagination(PaginationMeta.builder()
                            .totalPages(staffs.getTotalPages())
                            .totalItems(staffs.getTotalElements())
                            .currentPage(pageable.getPageNumber())
                            .pageSize(pageable.getPageSize())
                            .build())
            .build();
    }

    @Override
    public StaffResponse findById(long id) throws DataNotFoundException {
        return dtoConverter.toStaffResponse(userRepository
                         .findStaffById(id)
                         .orElseThrow(() -> new StaffNotFoundException(String.format("Staff with id %d not found", id))));
    }

    @Override
    public StaffResponse createNewStaff(StaffRegisterDTO staff) throws PermissionDeniedException {
        String email = staff.email();
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isPresent()) {
            throw new DataIntegrityViolationException("Email already exists");
        }

        Role role = roleRepository.findById(2L)
            .orElseThrow(() -> new DataNotFoundException("Staff Role not found"));

        if (role.getUserRole() == UserRole.MANAGER) {
            log.error("Cannot create manager account");
            throw new PermissionDeniedException("Cannot create manager account");
        }

//        if(staff.getIsSubscription()==null){
//            staff.setIsSubscription(0);
//        }

        User newUser = User.builder()
            .firstName(staff.firstName())
            .lastName(staff.lastName())
            .email(staff.email())
            .phoneNumber(staff.phoneNumber())
            .password(passwordEncoder.encode(staff.password()))
            .isActive(true)
            .isSubscription(true) //force
            .address(staff.address())
            // subscription
            .status(UserStatus.VERIFIED) //manager create staff, so staff is verified
            .dob(staff.dateOfBirth())
            .avatarUrl(staff.avatarUrl() == null
               ? """
                https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvtZSXoa7lU0IBaV41q5B1awCYijsFF5Sh-Q&s
                """
               : staff.avatarUrl())
            .googleAccountId(staff.googleAccountId())
            .accountBalance(0L) //new staff has 0 money when register
            .build();
        newUser.setRole(role);
        return dtoConverter.toStaffResponse(userRepository.save((newUser)));
    }

    @Override
    public StaffResponse updateMemberToStaff(long id) {
        Optional<User> user = userRepository.findById(id);
        if(user.isEmpty())
            throw new DataNotFoundException("User not found");
        if(userRepository.findStaffById(id).isPresent())
            throw new DataAlreadyExistException("User is already a staff");

        User newStaff = user.get();
        newStaff.setRole(new Role(2L, UserRole.STAFF));

        return dtoConverter.toStaffResponse(userRepository.save((newStaff)));
    }

    //manager will update staff here, the email and
    //phone number will be readonly on client side
    @Override
    public StaffResponse update(long id, UserDTO staff) {
        Optional<User> existingStaff = userRepository.findStaffById(id);
        if(existingStaff.isEmpty())
            throw new DataNotFoundException(String.format("Staff with id %d not found", id));

//        if(userRepository.findByEmail(staff.email()).isPresent())
//            throw new DataAlreadyExistException("Email already exist");
//
//        if(userRepository.findByPhoneNumber(staff.phoneNumber()).isPresent())
//            throw new DataAlreadyExistException("Phone number already exist");

        User staffToUpdate = existingStaff.get();
        staffToUpdate.setFirstName(staff.firstName());
        staffToUpdate.setLastName(staff.lastName());
        staffToUpdate.setPhoneNumber(staff.phoneNumber());
//        staffToUpdate.setEmail(staff.email());
//        staffToUpdate.setAddress(staff.address());
        staffToUpdate.setPassword(staff.password());
        staffToUpdate.setActive(staff.isActive());
        staffToUpdate.setSubscription(staff.isSubscription());
        staffToUpdate.setStatus(UserStatus.valueOf(staff.statusName()));
        staffToUpdate.setDob(DateTimeUtils.convertFromString(staff.dob()));
        staffToUpdate.setAvatarUrl(staff.avatarUrl());
        staffToUpdate.setGoogleAccountId(staff.googleAccountId());
        staffToUpdate.setAccountBalance(staff.accountBalance());

        return dtoConverter.toStaffResponse(userRepository.save(staffToUpdate));
    }

    @Override
    public void delete(long id) {
        userRepository.findStaffById(id)
            .orElseThrow(() -> new StaffNotFoundException(String.format("Staff with id %d not found", id)));
        //update isActive to false
        Optional<User> existingStaff = userRepository.findById(id);
        if(existingStaff.isEmpty())
            throw new DataNotFoundException(String.format("Staff with id %d not found", id));
        User staff = existingStaff.get();
        staff.setActive(false);
        userRepository.save(staff);
    }

    @Override
    public PageResponse<StaffResponse> findAllStaffWithActive(Pageable pageable) {
        Page<User> staffs = userRepository.findAllStaffWithActive(pageable);

        List<StaffResponse> staffResponses = staffs.getContent().stream()
            .map(dtoConverter::toStaffResponse)
            .toList();

        return PageResponse.<StaffResponse>pageBuilder()
            .data(staffResponses)
            .pagination(PaginationMeta.builder()
                            .totalPages(staffs.getTotalPages())
                            .totalItems(staffs.getTotalElements())
                            .currentPage(pageable.getPageNumber())
                            .pageSize(pageable.getPageSize())
                            .build())
            .statusCode(200)
            .isSuccess(true)
            .message("Get all staffs successfully")
            .build();
    }
}
