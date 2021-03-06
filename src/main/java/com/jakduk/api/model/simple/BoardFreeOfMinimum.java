package com.jakduk.api.model.simple;

import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * @author <a href="mailto:phjang1983@daum.net">Jang,Pyohwan</a>
 * @company  : http://jakduk.com
 * @date     : 2014. 11. 17.
 * @desc     :
 */

// BoardFreeSimple 로 대체하자.
@Deprecated
@Getter
@Document(collection = "boardFree")
public class BoardFreeOfMinimum {
	
	@Id
	private String id;
	
	private int seq;

}
