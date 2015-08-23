<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html ng-app="jakdukApp">
<head>
	<title><spring:message code="board.name.free"/> &middot; <spring:message code="common.jakduk"/></title>
	<jsp:include page="../include/html-header.jsp"></jsp:include>
</head>

<body>
<div class="wrapper">
	<jsp:include page="../include/navigation-header.jsp"/>
	
	<!--=== Breadcrumbs ===-->
	<div class="breadcrumbs">
		<div class="container">
			<h1 class="pull-left"><a href="<c:url value="/board/free/refresh"/>"><spring:message code="board.name.free"/></a></h1>
		</div><!--/container-->
	</div><!--/breadcrumbs-->
	<!--=== End Breadcrumbs ===-->		
	
	<!--=== Content Part ===-->
	<div class="container content" ng-controller="boardCtrl">
	
	<sec:authorize access="isAnonymous()">
		<c:set var="authRole" value="ANNONYMOUS"/>
	</sec:authorize>
	<sec:authorize access="hasAnyRole('ROLE_USER_01', 'ROLE_USER_02', 'ROLE_USER_03')">
		<c:set var="authRole" value="USER"/>
	</sec:authorize>
	
	<div class="row">
		<!--Top Likes Rows-->
		<div class="col-md-6">
               <h2 class="heading-sm">
                   <i class="icon-custom rounded-x icon-sm icon-color-u fa fa-thumbs-o-up"></i>
                   <span><spring:message code="board.top.likes"/></span>
               </h2>
		       <table class="table table-hover">
					<tbody>
						<tr ng-repeat="post in topLike">
							<td class="text-overflow max-width-240">
								<a ng-href='<c:url value="/board/free/{{post.seq}}?page=${boardListInfo.page}&category=${boardListInfo.category}"/>'>
									<strong ng-if="post.status.delete == 'delete'"><spring:message code="board.msg.deleted"/></strong>
									<strong ng-if="post.status.delete != 'delete'">{{post.subject}}</strong>
								</a>	
							</td>
							<td>
								<span class="text-primary">
									<i class="fa fa-thumbs-o-up"></i>
									<strong>{{post.count}}</strong>
								</span>	
							</td>
						</tr>                                
					</tbody>
				</table>                
           </div>	
           <!--End Top Likes Rows-->	
           <!--Top Comments Rows-->
		<div class="col-md-6">
               <h2 class="heading-sm">
                   <i class="icon-custom rounded-x icon-sm icon-color-u fa fa-comment-o"></i>
                   <span><spring:message code="board.top.comments"/></span>
               </h2>
	  			<table class="table table-hover">
	      			<tbody>
						<tr ng-repeat="post in topComment">
							<td class="text-overflow max-width-240">
								<a ng-href='<c:url value="/board/free/{{post.seq}}?page=${boardListInfo.page}&category=${boardListInfo.category}"/>'>
									<strong ng-if="post.status.delete == 'delete'"><spring:message code="board.msg.deleted"/></strong>
									<strong ng-if="post.status.delete != 'delete'">{{post.subject}}</strong>
								</a>	
							</td>
							<td>
								<span class="text-default">
									<i class="fa fa-comment-o"></i>
									<strong>{{post.count}}</strong>
								</span>	
							</td>
						</tr>  
					</tbody>
				</table>               
           </div>	           
		<!--End Top Comments Rows-->
	</div>	

	<div class="row">
		<div class="col-sm-6 margin-bottom-10">
			<div class="btn-group">
				<button type="button" class="btn-u btn-brd rounded dropdown-toggle" data-toggle="dropdown">
					<c:choose>
						<c:when test="${boardListInfo.category != 'none'}">
							<spring:message code="${categorys[boardListInfo.category]}"/>
						</c:when>
						<c:otherwise>
							<spring:message code="board.category"/>
						</c:otherwise>
					</c:choose>		
					<i class="fa fa-angle-down"></i>
				</button>
				<ul class="dropdown-menu" role="menu">
					<c:forEach items="${categorys}" var="category">
						<li><a href="?category=${category.key}"><spring:message code="${category.value}"/></a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="btn-group">
			<c:choose>
				<c:when test="${authRole == 'ANNONYMOUS'}">
				<button type="button" class="btn-u btn-brd rounded" onclick="needLogin();">
					<span aria-hidden="true" class="icon-pencil"></span>
				</button>	
				</c:when>
				<c:when test="${authRole == 'USER'}">
				<button type="button" class="btn-u btn-brd rounded" onclick="location.href='<c:url value="/board/free/write"/>'">
					<span aria-hidden="true" class="icon-pencil"></span>
				</button>	
				</c:when>	
			</c:choose>
			</div>
		</div>
		<div class="col-sm-6">
	       <div class="input-group margin-bottom-10">
	           <input type="text" class="form-control" ng-model="searchWords" ng-init="searchWords=''" 
	           ng-keypress="($event.which === 13)?btnEnter():return" 
	           placeholder='<spring:message code="search.placeholder.words"/>'>
	           <span class="input-group-btn">
	               <button class="btn-u" type="button" ng-click="btnEnter();"><i class="fa fa-search"></i></button>
	           </span>
	       </div>
		</div>			
	</div>
	
	<div class="panel panel-u">
	  <!-- Default panel contents -->
	  <div class="panel-heading hidden-xs">
	  	<div class="row">
	  		<div class="col-sm-2"><spring:message code="board.number"/> | <spring:message code="board.category"/></div>
	  		<div class="col-sm-4"><spring:message code="board.subject"/></div>
	  		<div class="col-sm-3"><spring:message code="board.writer"/> | <spring:message code="board.date"/></div>
	  		<div class="col-sm-3"><spring:message code="board.views"/> | <spring:message code="common.like"/> | <spring:message code="common.dislike"/></div>
	  	</div>  	
	  </div> <!-- /panel-heading -->
	
		<ul class="list-group">
			<!-- posts as notice -->
			<%@page import="java.util.Date"%>
			<%Date CurrentDate = new Date();%>
			<fmt:formatDate var="nowDate" value="<%=CurrentDate %>" pattern="yyyy-MM-dd" />
									
			<c:forEach items="${notices}" var="notice">
				<li class="list-group-item list-group-item-info">
					<div class="row">
						<div class="col-sm-2">
							<span aria-hidden="true" class="icon-directions visible-xs-inline"></span><spring:message code="board.notice"/>
						</div>
						<div class="col-sm-4">
							<c:if test="${notice.status.device == 'mobile'}"><i class="fa fa-mobile fa-lg"></i></c:if>
							<c:if test="${notice.status.device == 'tablet'}"><i class="fa fa-tablet fa-lg"></i></c:if>
							<c:if test="${fn:length(notice.galleries) > 0}"><span aria-hidden="true" class="icon-picture"></span></c:if>
							<a href="<c:url value="/board/free/${notice.seq}?page=${boardListInfo.page}&category=${boardListInfo.category}"/>">
								<c:choose>
									<c:when test="${notice.status.delete == 'delete'}">
										<strong><spring:message code="board.msg.deleted"/></strong>
									</c:when>
									<c:otherwise>
										<strong>${notice.subject}</strong>
									</c:otherwise>
								</c:choose>
								<c:if test="${!empty commentCount[notice.id]}">
									<span class="text-success">&nbsp;[${commentCount[notice.id]}]</span>
								</c:if>		
							</a>
						</div>
						<div class="col-sm-3">
							<span aria-hidden="true" class="icon-user visible-xs-inline"></span> ${notice.writer.username}
							|
							<fmt:formatDate var="postDate" value="${createDate[notice.id]}" pattern="yyyy-MM-dd" />
							<c:choose>
								<c:when test="${postDate < nowDate}">
									<fmt:formatDate value="${createDate[notice.id]}" pattern="${dateTimeFormat.date}" />
								</c:when>
								<c:otherwise>
									<fmt:formatDate value="${createDate[notice.id]}" pattern="${dateTimeFormat.time}" />
								</c:otherwise>
							</c:choose>					
						</div>
						<div class="col-sm-3 hidden-xs">
							<span aria-hidden="true" class="icon-eye"></span><strong> ${notice.views}</strong>
							<span class="text-primary">
								<i class="fa fa-thumbs-o-up"></i>
								<strong>
									<c:choose>
										<c:when test="${!empty usersLikingCount[notice.id]}">${usersLikingCount[notice.id]}</c:when>
										<c:otherwise>0</c:otherwise>
									</c:choose>
								</strong>
							</span>
							<span class="text-danger">
								<i class="fa fa-thumbs-o-down"></i>
								<strong>
									<c:choose>
										<c:when test="${!empty usersDislikingCount[notice.id]}">${usersDislikingCount[notice.id]}</c:when>
										<c:otherwise>0</c:otherwise>
									</c:choose>
								</strong>
							</span>						
						</div>
					</div>
				</li>
			</c:forEach>
			<!-- posts -->
			<c:forEach items="${posts}" var="post">
				<li class="list-group-item">
					<div class="row">
						<div class="col-sm-2">	
							${post.seq} 
							<span class="hidden-xs">|</span>
							<c:if test="${!empty post.categoryName}">
								<span aria-hidden="true" class="icon-directions visible-xs-inline"></span><spring:message code="${categorys[post.categoryName]}"/>
							</c:if>
						</div>
						<div class="col-sm-4">
							<c:if test="${post.status.device == 'mobile'}"><i class="fa fa-mobile fa-lg"></i></c:if>
							<c:if test="${post.status.device == 'tablet'}"><i class="fa fa-tablet fa-lg"></i></c:if>
							<c:if test="${fn:length(post.galleries) > 0}"><span aria-hidden="true" class="icon-picture"></span></c:if>
							<a href="<c:url value="/board/free/${post.seq}?page=${boardListInfo.page}&category=${boardListInfo.category}"/>">
								<c:choose>
									<c:when test="${post.status.delete == 'delete'}">
										<strong><spring:message code="board.msg.deleted"/></strong>
									</c:when>
									<c:otherwise>
										<strong>${post.subject}</strong>
									</c:otherwise>
								</c:choose>
								<c:if test="${!empty commentCount[post.id]}">
									<span class="text-success">&nbsp;[${commentCount[post.id]}]</span>
								</c:if>		
							</a>
						</div>
						
						<div class="col-sm-3">
							<span aria-hidden="true" class="icon-user visible-xs-inline"></span> ${post.writer.username}
							|
							<fmt:formatDate var="postDate" value="${createDate[post.id]}" pattern="yyyy-MM-dd" />
							<c:choose>
								<c:when test="${postDate < nowDate}">
									<fmt:formatDate value="${createDate[post.id]}" pattern="${dateTimeFormat.date}" />
								</c:when>
								<c:otherwise>
									<fmt:formatDate value="${createDate[post.id]}" pattern="${dateTimeFormat.time}" />
								</c:otherwise>
							</c:choose>		
						</div>
						<div class="col-sm-3">
							<span aria-hidden="true" class="icon-eye"></span><strong> ${post.views}</strong>
							<span class="text-primary">
								<i class="fa fa-thumbs-o-up"></i>
								<strong>
									<c:choose>
										<c:when test="${!empty usersLikingCount[post.id]}">${usersLikingCount[post.id]}</c:when>
										<c:otherwise>0</c:otherwise>
									</c:choose>
								</strong>
							</span>
							<span class="text-danger">
								<i class="fa fa-thumbs-o-down"></i>
								<strong>
									<c:choose>
										<c:when test="${!empty usersDislikingCount[post.id]}">${usersDislikingCount[post.id]}</c:when>
										<c:otherwise>0</c:otherwise>
									</c:choose>
								</strong>
							</span>		
						</div>	
					</div> <!-- /row -->	
				</li>
			</c:forEach>
		</ul>
	</div>

	<c:choose>
		<c:when test="${authRole == 'ANNONYMOUS'}">
		<button type="button" class="btn-u btn-brd rounded" onclick="needLogin();">
			<span aria-hidden="true" class="icon-pencil"></span>
		</button>	
		</c:when>
		<c:when test="${authRole == 'USER'}">
		<button type="button" class="btn-u btn-brd rounded" onclick="location.href='<c:url value="/board/free/write"/>'">
			<span aria-hidden="true" class="icon-pencil"></span>
		</button>	
		</c:when>	
	</c:choose>
	
	<div class="text-left" ng-show="totalItems > 0">
		<pagination ng-model="currentPage" total-items="totalItems" max-size="10" items-per-page="itemsPerPage"
		previous-text="&lsaquo;" next-text="&rsaquo;" ng-change="pageChanged()"></pagination>
	</div>	
	
	<!--=== End Content Part ===-->
	</div>
 
	<jsp:include page="../include/footer.jsp"/>
</div><!-- /.container -->

<!-- Bootstrap core JavaScript
  ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<%=request.getContextPath()%>/resources/jquery/dist/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/angular-animate/angular-animate.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/angular-bootstrap/ui-bootstrap-tpls.min.js"></script>

<script type="text/javascript">

var jakdukApp = angular.module("jakdukApp", ["ngAnimate", "ui.bootstrap"]);

jakdukApp.controller("boardCtrl", function($scope, $http) {
	$scope.dataTopPostConn = "none";
	$scope.topLike = [];
	$scope.topComment = [];
	
	angular.element(document).ready(function() {
		var page = parseInt("${boardListInfo.page}");
		var size = parseInt("${boardListInfo.size}");
		var total = Number("${totalPosts}");
		
		if (page > 0) {
			$scope.currentPage = page;
		} else {
			$scope.currentPage = 1;			
		}
		
		$scope.totalItems = total;
		$scope.itemsPerPage = size;
		
		$scope.getDataBestLike();
		App.init();
	});
	
	$scope.getDataBestLike = function() {
		var bUrl = '<c:url value="/board/data/free/top.json"/>';
		
		if ($scope.dataTopPostConn == "none") {
			
			var reqPromise = $http.get(bUrl);
			
			$scope.dataTopPostConn = "loading";
			
			reqPromise.success(function(data, status, headers, config) {
				$scope.topLike = data.topLike;
				$scope.topComment = data.topComment;
				
				$scope.dataTopPostConn = "none";
			});
			reqPromise.error(function(data, status, headers, config) {
				$scope.dataTopPostConn = "none";
				$scope.error = '<spring:message code="common.msg.error.network.unstable"/>';
			});
		}
	};
	
	$scope.btnEnter = function() {
		if ($scope.searchWords.trim() < 1) {
			return;
		}
		
		location.href = '<c:url value="/search?q=' + $scope.searchWords.trim() + '&w=PO;"/>';
	};
	
	$scope.pageChanged = function() {
		var page = $scope.currentPage;
		
		location.href = '<c:url value="/board/free?page=' + page + '&category=${boardListInfo.category}"/>';
	};	
});

function needLogin() {
	if (confirm('<spring:message code="board.msg.need.login.for.write"/>') == true) {
		location.href = '<c:url value="/board/free/write"/>';
	}
}
</script>

<jsp:include page="../include/body-footer.jsp"/>

</body>
</html>