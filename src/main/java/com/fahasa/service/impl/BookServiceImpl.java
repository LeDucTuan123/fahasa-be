package com.fahasa.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.BookDAO;
import com.fahasa.model.Book;
import com.fahasa.model.Product;
import com.fahasa.service.BookService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class BookServiceImpl implements BookService {

	@Autowired
	BookDAO bdao;

	@Override
	public List<Book> getAll() {
		return bdao.findAll();
	}

	@Override
	public Book findById(Integer id) {
		return bdao.findById(id).get();
	}

	@Override
	public List<Book> findBooksByParentId(Integer id) {
		return bdao.findBooksByParentId(id);
	}

	@Override
	public List<Book> findBooksByParentId2(Integer id) {
		return bdao.findBooksByParentId2(id);
	}

	@Override
	public List<Book> findBooksByParentId3(Integer id) {
		return bdao.findBooksByParentId3(id);
	}

//	@Override
//	public Book create(Book book) {
//		return bdao.save(book);
//	}

	@Override
	public Book update(Integer id ,Book book) {
		// return bdao.save(id,book);
		Book existingProduct = bdao.findById(id).orElse(null);

        if (existingProduct != null) {
            existingProduct.setTitle(book.getTitle());
			existingProduct.setAuthor(book.getAuthor());
			existingProduct.setImages(book.getImages());
            existingProduct.setPrice(book.getPrice());
			existingProduct.setDiscount(book.getDiscount());
			existingProduct.setDescription(book.getDescription());
			existingProduct.setCats(book.getCats());
            // Lưu sản phẩm đã cập nhật vào cơ sở dữ liệu
            bdao.save(existingProduct);
        } else {
            // Xử lý khi không tìm thấy sản phẩm với ID đã cho
            // Có thể ném một ngoại lệ hoặc thực hiện các hành động phù hợp khác
        }
		return existingProduct;
	}

	@Override
	public void delete(Integer id) {
		bdao.deleteById(id);
		
	}

	@Override
	public Book create(JsonNode book) {
		System.out.println(book);
		ObjectMapper mapper = new ObjectMapper();
		Book b = mapper.convertValue(book, Book.class);
		bdao.save(b);
		return null;
	}

}
