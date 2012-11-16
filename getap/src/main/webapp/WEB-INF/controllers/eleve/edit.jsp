<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:if test="${dvctap_cree or dvctap_modifiee_eleve }">
	<h3 class="titre3">Modifier ma Demande</h3>
	
	<form:form modelAttribute="formDemandeConsoTempsAccPers" action="doedit"
	  method="post">
	  <form:errors path="*" cssClass="errors" />
	
	  <div class="section">
	    <fieldset>
	      <div class="form-row">
	        <label for="datepicker" >Date de l'action :</label>
	        <div class="input">
	          <form:input id="datepicker" path="dateAction" />
	        </div>
	      </div>
	      
	      <div class="form-row">
	        <label for="minutes">Temps d'aide personalisée :</label>
	        <%-- <div class="input">
	          <form:input path="minutes" />
	        </div> --%>
	        <select name="minutes" id="minutes">
				<% for(int i=5; i<=300; i+=5) {%>
					<c:set var="valueI" value="<%=i%>"/>
					<% if( (int) i/60 != 0 ){%>
						<c:if test="${valueI == minute }">
							<option selected="selected" value="<%=i%>"><%=(int)i/60 %>h <%=(int)i%60 %>min</option>
						</c:if>
						<c:if test="${valueI != minute }">
							<option value="<%=i%>"><%=(int)i/60 %>h <%=(int)i%60 %>min</option>
						</c:if>
					<% } else { %>
						<c:if test="${valueI == minute }">
							<option selected="selected" value="<%=i%>"><%=(int)i%60 %>min</option>
						</c:if>
						<c:if test="${valueI != minute }">
							<option value="<%=i%>"><%=(int)i%60 %>min</option>
						</c:if>
					<% } 
				}%>
			</select>
	      </div>
  
	      <div class="form-row">
	       <label for="profId">Les professeurs :</label>
	       <form:select path="profId" items="${lesProfs}" itemValue="id" itemLabel="nom"></form:select>
	      </div>
	      
	      <div class="form-row">
				<label for="accPersId">Type d'aide personnalisée : </label> <select
					id="accPersId" name="accPersId" onchange="testAcc()">
					<c:forEach items="${lesAP}" var="ap">
						<option value="${ap.id}" label="${ap.nom}">${ap.nom}</option>
					</c:forEach>
					<option value="0" label="Autre">Autre</option>
				</select>
			</div>

			<div class="from-row" id="inputAcc"
				style="display: none; visibility: hidden;">
				<label for="accPersNom">Aide personnalisée : </label>
				<form:input path="accPersNom" />
			</div>

	    </fieldset>
	
	        
	          <form:hidden path="id" />
	    <br/>
	
	    <div id="buttonGroup">
	    <a href="<c:url value="/app/eleve/mesdctap" />"
		style="text-decoration: none"><input type="button" value="Retour">
		</a>
	      <input type="submit" value="Modifier" />
	    </div>
	  </div>
	</form:form>
</c:if>
<c:if test="${!dctap.creeeParLeleve and !dctap.modifParEleve }">
	<script type="text/javascript">
		window.location="mesdctap"
	</script>
</c:if>