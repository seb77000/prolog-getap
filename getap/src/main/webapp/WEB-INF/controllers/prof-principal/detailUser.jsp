<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="timeTT" value="0" />
<c:set var="timeVal" value="0" />
<c:set var="timeRef" value="0" />
<c:set var="timeAtt" value="0" />

<h3 class="titre3">Détail des demandes de ${utilisateur.nom} ${utilisateur.prenom}</h3>
<div id="accordion">
	<h3>
		<a href="#">Demandes Validées (${dvctap_acceptee_modif_prof + dvctap_validee_prof})</a>
	</h3>
	<table class="display dataTable">
		<thead>
			<tr class="header">
				<th>Nom du Professeur</th>
				<th>Type d'accompagnement</th>
				<th>Temps</th>
				<th>Date</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sesDCTAPeleve}" var="dctap">
				<c:set var="timeTT" value="${timeTT + dctap.minutes}" />
				<c:if test="${dctap.creeeParLeleve || dctap.valideParProf }">
					<tr>
						<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
						<td>${dctap.accPers.nom}</td>
						<td><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
						<td>${dctap.dateAction}</td>
					</tr>
					<c:set var="timeVal" value="${timeVal + dctap.minutes}" />
				</c:if>
			</c:forEach>
		</tbody>
	</table>

	<script>
			$(document).ready(function() {
				 $("#progressbar").progressbar({ value: ${timeVal/(72*60)*100} });
			});
		</script>

	<h3>
		<a href="#">Demandes Refusées (${dvctap_rejetee + dvctap_annulee_eleve + dvctap_refus_prof})</a>
	</h3>
	<table class="display dataTable">
		<thead>
			<tr class="header">
				<th>Nom du Professeur</th>
				<th>Type d'accompagnement</th>
				<th>Temps</th>
				<th>Date</th>
				<th>Cause</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sesDCTAPeleve}" var="dctap">
				<c:if
					test="${dctap.rejeteeParLeleve || dctap.refuseParProf || dctap.annuleeEleve}">
					<tr>
						<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
						<td>${dctap.accPers.nom}</td>
						<td><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
						<td>${dctap.dateAction}</td>
						<c:if test="${dctap.rejeteeParLeleve}">
							<td>Refus élève</td>
						</c:if>
						<c:if test="${dctap.annuleeEleve}">
							<td>Annulé</td>
						</c:if>
						<c:if test="${dctap.refuseParProf}">
							<td>Refus prof</td>
						</c:if>
					</tr>
					<c:set var="timeRef" value="${timeRef + dctap.minutes}" />
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<h3>
		<a href="#">Demandes en Cours (${dvctap_cree + dvctap_modifiee_eleve + modifie_prof})</a>
	</h3>
	<table class="display dataTable">
		<thead>
			<tr class="header">
				<th>Nom du Professeur</th>
				<th>Type d'accompagnement</th>
				<th>Temps</th>
				<th>Date</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sesDCTAPeleve}" var="dctap">
				<c:if
					test="${dctap.creeeParLeleve || dctap.modifParEleve || dctap.dateModifieProf || dctap.dureeModifieProf || dctap.modifParProf}">
					<tr>
						<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
						<td>${dctap.accPers.nom}</td>
						<td><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
						<td>${dctap.dateAction}</td>
					</tr>
					<c:set var="timeAtt" value="${timeAtt + dctap.minutes}" />
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<h3>
		<a href="#">Statistiques de l'élève</a>
	</h3>
	<table class="display" id="stats">
		<thead>
			<tr>
				<th>Temps total effectué</th>
				<th>Temps total validé</th>
				<th>Temps total en attente</th>
				<th>Temps total refusé</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><fmt:formatNumber value="${timeTT/60-(timeTT%60/60)}"
						pattern="#00" />h<fmt:formatNumber
										value="${timeTT%60}"
										pattern="#00" /></td>
				<td><fmt:formatNumber value="${timeVal/60-(timeVal%60/60)}"
						pattern="#00" />h<fmt:formatNumber
										value="${timeVal%60}"
										pattern="#00" /></td>
				<td><fmt:formatNumber value="${timeAtt/60-(timeAtt%60/60)}"
						pattern="#00" />h<fmt:formatNumber
										value="${timeAtt%60}"
										pattern="#00" /></td>
				<td><fmt:formatNumber value="${timeRef/60-(timeRef%60/60)}"
						pattern="#00" />h<fmt:formatNumber
										value="${timeRef%60}"
										pattern="#00" /></td>
			</tr>
			<tr>

				<td><div id="progressbar"></div> <fmt:formatNumber
						value="${timeVal/(72*60)*100}" pattern="#0.00" />% - 72h requises</td>
				<td id="statsValide"><fmt:formatNumber
						value="${timeVal/timeTT*100}" pattern="#0.00" />%</td>
				<td id="statsAttente"><fmt:formatNumber
						value="${timeAtt/timeTT*100}" pattern="#0.00" />%</td>
				<td id="statsRefuse"><fmt:formatNumber
						value="${timeRef/timeTT*100}" pattern="#0.00" />%</td>
			</tr>
		</tbody>
	</table>
</div>