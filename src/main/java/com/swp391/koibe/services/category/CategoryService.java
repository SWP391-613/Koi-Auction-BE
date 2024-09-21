package com.swp391.koibe.services.category;

import com.swp391.koibe.dtos.CategoryDTO;
import com.swp391.koibe.models.Category;
import com.swp391.koibe.repositories.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryService implements ICategoryService{

    private final CategoryRepository categoryRepository;

    @Override
    public Category createCategory(CategoryDTO category) {
        return null;
    }

    @Override
    public Category getCategoryById(long id) {
        return null;
    }

    @Override
    public Page<Category> getAllCategories(Pageable pageable) {
        return categoryRepository.findAll(pageable);
    }

    @Override
    public Category updateCategory(long categoryId, CategoryDTO category) {
        return null;
    }

    @Override
    public void deleteCategory(long id) {

    }
}
