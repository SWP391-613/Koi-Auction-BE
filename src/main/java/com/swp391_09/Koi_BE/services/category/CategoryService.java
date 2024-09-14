package com.swp391_09.Koi_BE.services.category;

import com.swp391_09.Koi_BE.dtos.CategoryDTO;
import com.swp391_09.Koi_BE.models.Category;
import com.swp391_09.Koi_BE.repositories.CategoryRepository;
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
