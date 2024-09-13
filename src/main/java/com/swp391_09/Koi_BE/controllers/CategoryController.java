package com.swp391_09.Koi_BE.controllers;

import com.swp391_09.Koi_BE.models.Category;
import com.swp391_09.Koi_BE.services.ICategoryService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/categories")
@RequiredArgsConstructor
public class CategoryController {

    private final ICategoryService categoryService;

    @GetMapping("")
    public ResponseEntity<List<Category>> getAllCategories(
        @RequestParam("page") int page,
        @RequestParam("limit") int limit
    ) {
        try{
            PageRequest pageRequest = PageRequest.of(page, limit);
            Page<Category> categories = categoryService.getAllCategories(pageRequest);
            return ResponseEntity.ok(categories.getContent());
        }catch (Exception e){
            return ResponseEntity.badRequest().body(null);
        }

    }


}
