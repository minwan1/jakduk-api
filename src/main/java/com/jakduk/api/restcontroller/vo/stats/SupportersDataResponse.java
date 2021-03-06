package com.jakduk.api.restcontroller.vo.stats;

import com.jakduk.api.model.etc.SupporterCount;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@ApiModel(value = "서포터즈 응답 객체")
public class SupportersDataResponse {
	@ApiModelProperty(value = "클럽별 서포터 인원")
	private List<SupporterCount> supporters;

	@ApiModelProperty(value = "서포터 회원")
	private Integer supportersTotal;

	@ApiModelProperty(value = "작두 회원")
	private Integer usersTotal;
}
