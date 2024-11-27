package com.swp391.koibe.services.category;

import com.swp391.koibe.dtos.CategoryDTO;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.Category;
import com.swp391.koibe.responses.CategoryResponse;
import com.swp391.koibe.responses.base.PageResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

public interface ICategoryService {

    Category createCategory(CategoryDTO category) throws DataAlreadyExistException;
    Category getById(long id) throws DataNotFoundException;
    PageResponse<CategoryResponse> getAllCategories(PageRequest pageRequest);
    void update(long categoryId, CategoryDTO category) throws DataNotFoundException;
    void delete(long id);

}
