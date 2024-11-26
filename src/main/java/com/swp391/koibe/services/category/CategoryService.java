package com.swp391.koibe.services.category;

import com.swp391.koibe.dtos.CategoryDTO;
import com.swp391.koibe.exceptions.CategoryAlreadyExistException;
import com.swp391.koibe.exceptions.CategoryNotFoundException;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.metadata.PaginationMeta;
import com.swp391.koibe.models.Category;
import com.swp391.koibe.repositories.CategoryRepository;
import com.swp391.koibe.responses.CategoryResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.utils.DTOConverter;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryService implements ICategoryService{

    private final CategoryRepository categoryRepository;
    private final DTOConverter dtoConverter;

    @Override
    public Category createCategory(CategoryDTO category) throws DataAlreadyExistException {

        categoryRepository.findByName(category.name()).ifPresent(c -> {
            throw new CategoryAlreadyExistException("Category already exist");
        });

        Category newCategory = Category.builder()
            .name(category.name())
            .build();

        return categoryRepository.save(newCategory);
    }

    @Override
    public Category getById(int id) throws DataNotFoundException {
        return categoryRepository.findById(id).orElseThrow(() -> new CategoryNotFoundException("Category not found"));
    }

    @Override
    public PageResponse<CategoryResponse> getAllCategories(PageRequest pageRequest) {
        Page<Category> categoriesPage = categoryRepository.findAll(pageRequest);

        List<CategoryResponse> categoryResponses = categoriesPage.getContent().stream()
            .map(dtoConverter::convertToCategoryDTO)
            .collect(Collectors.toList());

        return PageResponse.<CategoryResponse>pageBuilder()
            .data(categoryResponses)
            .pagination(PaginationMeta.builder()
                            .totalPages(categoriesPage.getTotalPages())
                            .totalItems(categoriesPage.getTotalElements())
                            .currentPage(pageRequest.getPageNumber())
                            .pageSize(pageRequest.getPageSize())
                            .build())
            .statusCode(200)
            .isSuccess(true)
            .message("Categories fetched successfully")
            .build();
    }

    @Override
    public void update(int categoryId, CategoryDTO category)
        throws DataNotFoundException {

        Category existingCategory = getById(categoryId);
        existingCategory.setName(category.name());
        categoryRepository.save(existingCategory);
    }

    @Override
    public void delete(int id) {

        categoryRepository.deleteById(id);

    }
}
