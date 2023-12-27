package com.fahasa.RestController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.dao.BookDAO;
import com.fahasa.model.Book;
import com.fahasa.model.Product;
import com.fahasa.service.BookService;
import com.fasterxml.jackson.databind.JsonNode;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/book")
//@RequestMapping(value = "/rest/book", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE, headers = "Accept=application/json;charset=ISO-8859-1")
public class BookRestController {

	@Autowired
	BookService service;
	@Autowired
	private BookDAO BookDAO;

	@GetMapping
	public List<Book> main() {
		return service.getAll();
	}

	@GetMapping("{id}")
	public Book getProduct(@PathVariable("id") Integer id) {
		return service.findById(id);
	}

	@GetMapping("/search")
	public List<Book> searchByName(@RequestParam String q) {
		return BookDAO.findByTitleContaining(q);
	}

	@GetMapping("/cate/{id}")
	public List<Book> findBooksByCate(@PathVariable("id") Integer id) {
		return BookDAO.findBooksByParentId(id);
	}

	@GetMapping("/cate2/{id}")
	public List<Book> findBooksByCate2(@PathVariable("id") Integer id) {
		return BookDAO.findBooksByParentId2(id);
	}

	@GetMapping("/cate3/{id}")
	public List<Book> findBooksByCate3(@PathVariable("id") Integer id) {
		return BookDAO.findBooksByParentId3(id);
	}

//	@PostMapping(headers = "Content-Type=application/json;charset=UTF-8", consumes = MediaType.APPLICATION_JSON_VALUE)
//	public Book create(@RequestBody Book book) {
//		return service.create(book);
//	}
	
	@PostMapping()
	public void create(@RequestBody JsonNode book) {
		service.create(book);
	}

	@PutMapping("{id}")
	public ResponseEntity<String> update(@PathVariable("id") Integer id, @RequestBody Book book) {
		service.update(id,book);

		return ResponseEntity.ok("Product updated successfully");
	}

	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") Integer id) {
		 service.delete(id);
	}


	public ResponseEntity<String> yourEndpoint(@RequestBody String requestBody,
                                               HttpServletRequest request,
                                               HttpServletResponse response) {
        // Lấy giá trị của header 'Content-Type' từ yêu cầu
        String contentType = request.getHeader("Content-Type");

        // Lấy giá trị của header 'Accept' từ yêu cầu
        String acceptHeader = request.getHeader("Accept");

        // Xử lý logic của bạn dựa trên giá trị của các headers
        // ...

        // Trả về phản hồi cho client
        String responseBody = "Your response message";
        return ResponseEntity.status(HttpStatus.OK)
                             .contentType(MediaType.APPLICATION_JSON)
                             .body(responseBody);
    }
}
