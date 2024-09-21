package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.dtos.CategoryDTO;
import com.swp391_09.Koi_BE.models.Category;
import com.swp391_09.Koi_BE.repositories.CategoryRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
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
    public Category getCategoryById(int id) {
        return null;
    }

    @Override
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }

    @Override
    public Category updateCategory(long categoryId, Category categoryDTO) {
        return null;
    }

    @Override
    public void deleteCategory(long id) {

    }
}
