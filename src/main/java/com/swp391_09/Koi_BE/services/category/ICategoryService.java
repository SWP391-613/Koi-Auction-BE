package com.swp391_09.Koi_BE.services.category;

import com.swp391_09.Koi_BE.dtos.CategoryDTO;
import com.swp391_09.Koi_BE.models.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ICategoryService {

    Category createCategory(CategoryDTO category);
    Category getCategoryById(long id);
    Page<Category> getAllCategories(Pageable pageable);
    Category updateCategory(long categoryId, CategoryDTO category);
    void deleteCategory(long id);

}