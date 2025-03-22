package com.swp391.koibe.domain.category;

import com.swp391.koibe.api.ApiResponse;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import java.util.List;

public interface ICategoryService {

    Category createCategory(CategoryDTO category) throws DataAlreadyExistException;
    Category getById(long id) throws DataNotFoundException;
    ApiResponse<List<CategoryResponse>> getAll();
    void update(long categoryId, CategoryDTO category) throws DataNotFoundException;
    void delete(long id);

}
