package com.jakduk.api.repository.board.free.comment;

import com.jakduk.api.model.simple.BoardFreeCommentOnHome;
import org.springframework.data.mongodb.repository.MongoRepository;


/**
 * @author <a href="mailto:phjang1983@daum.net">Jang,Pyohwan</a>
 * @company  : http://jakduk.com
 * @date     : 2015. 2. 27.
 * @desc     :
 */
public interface BoardFreeCommentOnHomeRepository extends MongoRepository<BoardFreeCommentOnHome, String>{

}
