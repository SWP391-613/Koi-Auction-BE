package com.swp391.koibe.domain.category;

import com.swp391.koibe.api.ApiResponse;
import com.swp391.koibe.components.LocalizationUtils;
import com.swp391.koibe.exceptions.CategoryAlreadyExistException;
import com.swp391.koibe.exceptions.CategoryNotFoundException;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.repositories.CategoryRepository;
import com.swp391.koibe.utils.DTOConverter;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryService implements ICategoryService{

    private final CategoryRepository categoryRepository;
    private final DTOConverter dtoConverter;
    private final LocalizationUtils localizationUtils;

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
    public Category getById(long id) throws DataNotFoundException {
        return categoryRepository.findById(id).orElseThrow(() -> new CategoryNotFoundException("Category not found"));
    }

    @Override
    public ApiResponse<List<CategoryResponse>> getAll() {
        if(categoryRepository.findAll().isEmpty())
            throw new DataNotFoundException("No category found");

        List<CategoryResponse> categoryResponses = categoryRepository.findAll().stream()
            .map(dtoConverter::toCategoryResponse)
            .collect(Collectors.toList());

        return ApiResponse.<List<CategoryResponse>>builder()
            .data(categoryResponses)
            .statusCode(200)
            .isSuccess(true)
            .message("Categories fetched successfully")
            .build();
    }

    @Override
    public void update(long categoryId, CategoryDTO category)
        throws DataNotFoundException {

        Category existingCategory = getById(categoryId);
        existingCategory.setName(category.name());
        categoryRepository.save(existingCategory);
    }

    @Override
    public void delete(long id) {

        categoryRepository.deleteById(id);

    }
}
