package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.dtos.CategoryDTO;
import com.swp391_09.Koi_BE.models.Category;
import java.util.List;

public interface ICategoryService {

    Category createCategory(CategoryDTO category);
    Category getCategoryById(int id);
    List<Category> getAllCategories();
    Category updateCategory(long categoryId, Category categoryDTO);
    void deleteCategory(long id);

}
