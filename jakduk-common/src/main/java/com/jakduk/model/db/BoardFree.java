package com.jakduk.model.db;

import java.util.List;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import com.jakduk.model.embedded.BoardHistory;
import com.jakduk.model.embedded.BoardImage;
import com.jakduk.model.embedded.BoardStatus;
import com.jakduk.model.embedded.CommonFeelingUser;
import com.jakduk.model.embedded.CommonWriter;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * 자유게시판 모델
 * @author pyohwan
 *
 */

@Data
@RepositoryRestResource
@Document
public class BoardFree {

	/**
	 * ID
	 */
	@Id  @GeneratedValue(strategy=GenerationType.AUTO)
	private String id;

	/**
	 * 작성자
	 */
	
	private CommonWriter writer;
	
	/**
	 * 글 제목
	 */
	private String subject;
	
	/**
	 * 글 내용
	 */
	private String content;
	
	/**
	 * 글 번호
	 */
	private int seq;
	
	/**
	 * 분류 ID
	 */
	private String categoryName;
	
	/**
	 * 조회
	 */
	private int views;
	
	private List<CommonFeelingUser> usersLiking;
	
	private List<CommonFeelingUser> usersDisliking;
	
	private BoardStatus status;
	
	private List<BoardHistory> history;
	
	private List<BoardImage> galleries;
}
