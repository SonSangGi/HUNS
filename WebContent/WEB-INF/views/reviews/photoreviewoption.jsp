<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div style="text-align: center; padding: 30px;">
	<img src="/images/reviews/testimages/real_1.jpg" style="width: 900px; text-align: center;" />
</div>
<div style="text-align: center;">
	<select onchange="searchHR();" class="form-control" name="option1" style="width: 134px; height: 47px; margin-right: 30px;" >
		<option value="">성별</option>
		<option value="male" ${param.option1 eq 'male' ? 'selected' : '' }>남자</option>
		<option value="female" ${param.option1 eq 'female' ? 'selected' : '' }>여자</option>
	</select> 
	<select onchange="searchHR();" class="form-control" name="option2" style="width: 134px; height: 47px; margin-right: 30px;">
		<option value="">연령대</option>
		<option value="10" ${param.option2 eq '10' ? 'selected' : '' }>10대</option>
		<option value="20" ${param.option2 eq '20' ? 'selected' : '' }>20대</option>
		<option value="30" ${param.option2 eq '30' ? 'selected' : '' }>30대</option>
		<option value="40" ${param.option2 eq '40' ? 'selected' : '' }>40대</option>
		<option value="50" ${param.option2 eq '50' ? 'selected' : '' }>40대이상</option>
	</select> 
	<select onchange="searchHR();" class="form-control" name="option3" style="width: 134px; height: 47px; margin-right: 30px;">
		<option value="">키</option>
		<option value="130" ${param.option3 eq '130' ? 'selected' : '' }>139cm 이하</option>
		<option value="140" ${param.option3 eq '140' ? 'selected' : '' }>140 - 149 cm</option>
		<option value="150" ${param.option3 eq '150' ? 'selected' : '' }>150 - 159 cm</option>
		<option value="160" ${param.option3 eq '160' ? 'selected' : '' }>160 - 169 cm</option>
		<option value="170" ${param.option3 eq '170' ? 'selected' : '' }>170 - 179 cm</option>
		<option value="180" ${param.option3 eq '180' ? 'selected' : '' }>180 - 189 cm</option>
		<option value="190" ${param.option3 eq '190' ? 'selected' : '' }>190 cm 이상</option>
	</select>
	<select onchange="searchHR();" class="form-control" name="option4" style="width: 134px; height: 47px; margin-right: 30px;">
		<option value="">몸무게</option>
		<option value="30" ${param.option4 eq '30' ? 'selected' : '' }>~ 40kg</option>
		<option value="40" ${param.option4 eq '40' ? 'selected' : '' }>41 ~ 49 kg</option>
		<option value="50" ${param.option4 eq '50' ? 'selected' : '' }>51 ~ 59 kg</option>
		<option value="60" ${param.option4 eq '60' ? 'selected' : '' }>61 ~ 69 kg</option>
		<option value="70" ${param.option4 eq '70' ? 'selected' : '' }>71 ~ 79 kg</option>
		<option value="80" ${param.option4 eq '80' ? 'selected' : '' }>81 ~ 89 kg</option>
		<option value="90" ${param.option4 eq '90' ? 'selected' : '' }>90 ~ kg</option>
	</select> 
	<select onchange="searchHR();" class="form-control" name="option5" style="width: 134px; height: 47px;">
		<option value="">평소사이즈</option>
		<option value="90" ${param.option5 eq '90' ? 'selected' : '' }>XS</option>
		<option value="95" ${param.option5 eq '95' ? 'selected' : '' }>S</option>
		<option value="100" ${param.option5 eq '100' ? 'selected' : '' }>M</option>
		<option value="105" ${param.option5 eq '105' ? 'selected' : '' }>L</option>
		<option value="110" ${param.option5 eq '110' ? 'selected' : '' }>XL</option>
	</select>
</div>
