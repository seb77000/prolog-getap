<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<c:set var="timeTT" value="0" />
<c:set var="timeVal" value="0" />
<c:set var="timeRef" value="0" />
<c:set var="timeAtt" value="0" />

<h3 class="titre3">Détail des demandes de ${utilisateur.nom}
	${utilisateur.prenom}</h3>
<div id="accordion">
	<h3>
		<a href="#">Demandes Validées (${dvctap_acceptee_modif_prof + dvctap_validee_prof})</a>
	</h3>
	<table class="display dataTable">
		<thead>
			<tr class="header">
				<c:if test="${utilisateur.role == 'eleve'}">
					<th>Nom du Professeur</th>
				</c:if>
				<c:if
					test="${utilisateur.role == 'prof-internant' or utilisateur.role == 'prof-principal'}">
					<th>Nom de l'élève</th>
				</c:if>
				<th>Type d'accompagnement</th>
				<th>Temps</th>
				<th>Date</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${utilisateur.role == 'eleve'}">
				<c:forEach items="${sesDCTAPeleve}" var="dctap">
					<c:set var="timeTT" value="${timeTT + dctap.minutes}" />
					<c:if
						test="${dctap.creeeParLeleve || dctap.modifParEleve || dctap.dateModifieProf || dctap.dureeModifieProf || dctap.modifParProf}">
						<c:set var="timeAtt" value="${timeAtt + dctap.minutes}" />
					</c:if>
					<c:if
						test="${dctap.accepteEleveApresModifProf || dctap.valideParProf }">
						<tr>
							<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
							<td>${dctap.accPers.nom}</td>
							<td><fmt:formatNumber
									value="${dctap.minutes/60-(dctap.minutes%60/60)}" pattern="#00" />h<fmt:formatNumber
									value="${dctap.minutes%60}" pattern="#00" /></td>
							<td>${dctap.dateAction}</td>
						</tr>
						<c:set var="timeVal" value="${timeVal + dctap.minutes}" />
					</c:if>
				</c:forEach>
			</c:if>
			<c:if
				test="${utilisateur.role == 'prof-internant' or utilisateur.role == 'prof-principal'}">
				<c:forEach items="${sesDCTAPprof}" var="dctap">
					<c:set var="timeTT" value="${timeTT + dctap.minutes}" />
					<c:if
						test="${dctap.creeeParLeleve || dctap.modifParEleve || dctap.dateModifieProf || dctap.dureeModifieProf || dctap.modifParProf}">
						<c:set var="timeAtt" value="${timeAtt + dctap.minutes}" />
					</c:if>
					<c:if
						test="${dctap.accepteEleveApresModifProf || dctap.valideParProf }">
						<tr>
							<td>${dctap.eleve.nom} ${dctap.eleve.prenom}</td>
							<td>${dctap.accPers.nom}</td>
							<td><fmt:formatNumber
									value="${dctap.minutes/60-(dctap.minutes%60/60)}" pattern="#00" />h<fmt:formatNumber
									value="${dctap.minutes%60}" pattern="#00" /></td>
							<td>${dctap.dateAction}</td>
						</tr>
						<c:set var="timeVal" value="${timeVal + dctap.minutes}" />
					</c:if>
				</c:forEach>
			</c:if>
		</tbody>
	</table>

	<c:if test="${utilisateur.role == 'eleve'}">
		<script>
$(document).ready(function() {
$("#progressbar").progressbar({ value: ${timeVal/(72*60)*100} });
});
</script>
	</c:if>

	<h3>
		<a href="#">Demandes Refusées (${dvctap_rejetee +
			dvctap_annulee_eleve + dvctap_refus_prof})</a>
	</h3>
	<table class="display dataTable">
		<thead>
			<tr class="header">
				<c:if test="${utilisateur.role == 'eleve'}">
					<th>Nom du Professeur</th>
				</c:if>
				<c:if
					test="${utilisateur.role == 'prof-internant' or utilisateur.role == 'prof-principal'}">
					<th>Nom de l'élève</th>
				</c:if>
				<th>Type d'accompagnement</th>
				<th>Temps</th>
				<th>Date</th>
				<th>Cause</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${utilisateur.role == 'eleve'}">
				<c:forEach items="${sesDCTAPeleve}" var="dctap">
					<c:if
						test="${dctap.rejeteeParLeleve || dctap.refuseParProf || dctap.annuleeEleve}">
						<tr>
							<td>${dctap.prof.nom} ${dctap.prof.nom}</td>
							<td>${dctap.accPers.nom}</td>
							<td><fmt:formatNumber
									value="${dctap.minutes/60-(dctap.minutes%60/60)}" pattern="#00" />h<fmt:formatNumber
									value="${dctap.minutes%60}" pattern="#00" /></td>
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
			</c:if>
			<c:if
				test="${utilisateur.role == 'prof-internant' or utilisateur.role == 'prof-principal'}">
				<c:forEach items="${sesDCTAPprof}" var="dctap">
					<c:if
						test="${dctap.rejeteeParLeleve || dctap.refuseParProf || dctap.annuleeEleve}">
						<tr>
							<td>${dctap.eleve.nom} ${dctap.eleve.prenom}</td>
							<td>${dctap.accPers.nom}</td>
							<td><fmt:formatNumber
									value="${dctap.minutes/60-(dctap.minutes%60/60)}" pattern="#00" />h<fmt:formatNumber
									value="${dctap.minutes%60}" pattern="#00" /></td>
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
			</c:if>
		</tbody>
	</table>
	<h3>
		<c:if test="${utilisateur.role == 'eleve'}">
			<a href="#">Statistiques de l'élève</a>
		</c:if>
		<c:if
			test="${utilisateur.role == 'prof-internant' or utilisateur.role == 'prof-principal'}">
			<a href="#">Statistiques du professeur</a>
		</c:if>
	</h3>
	<table class="display" id="stats">
		<thead>
			<tr>
				<c:if test="${utilisateur.role == 'eleve'}">
					<th>Temps total effectué</th>
				</c:if>
				<th>Temps total validé</th>
				<th>Temps total en attente</th>
				<th>Temps total refusé</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<c:if test="${utilisateur.role == 'eleve'}">
					<td><fmt:formatNumber value="${timeTT/60-(timeTT%60/60)}"
							pattern="#00" />h<fmt:formatNumber value="${timeTT%60}"
							pattern="#00" /></td>
				</c:if>
				<td><fmt:formatNumber value="${timeVal/60-(timeVal%60/60)}"
						pattern="#00" />h<fmt:formatNumber value="${timeVal%60}"
						pattern="#00" /></td>
				<td><fmt:formatNumber value="${timeAtt/60-(timeAtt%60/60)}"
						pattern="#00" />h<fmt:formatNumber value="${timeAtt%60}"
						pattern="#00" /></td>
				<td><fmt:formatNumber value="${timeRef/60-(timeRef%60/60)}"
						pattern="#00" />h<fmt:formatNumber value="${timeRef%60}"
						pattern="#00" /></td>
			</tr>
			<tr>
				<c:if test="${utilisateur.role == 'eleve'}">
					<td><div id="progressbar"></div> <fmt:formatNumber
							value="${timeVal/(72*60)*100}" pattern="#0.00" />% - 72h
						requises</td>
				</c:if>
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
<table class="legend2">
	<tr>
		<td><a
			href="<c:url value="/app/admin/exportStats/${utilisateur.id}" />"><img
				src="<c:url value="../../images/pdfdl.png"/>" width="64" height="64" />
				<div>Export PDF statistiques</div> </a></td>
		<td><a
			href="<c:url value="/app/admin/exportDemandeCsv/${utilisateur.id}" />"><img
				src="<c:url value="../../images/exportcsv.png"/>" width="64"
				height="64" />
				<div>Export CSV des demandes</div> </a></td>
	</tr>
</table>