<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="org.ldv.sio.getap.app.service.impl.DBManagerGeTAP"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<h3 class="titre3">Mes demandes de validations</h3>

<c:if test="${empty mesdctaps}">
	Il n'y a encore aucune demande. 
</c:if>

<c:if test="${not empty mesdctaps}">
	<c:set var="timeTT" value="0" />
	<c:set var="timeRef" value="0" />
	<c:set var="timeAtt" value="0" />
	<c:set var="timeVal" value="0" />
	<table class="legend2">
		<tr>
			<td><img src="../../images/valid.png" width="24" height="24"/> : Confirmer</td>
			<td><img src="../../images/modif.png" width="24" height="24"/> : Modifier</td>
			<td><img src="../../images/suppr.png" width="24" height="24"/> : Supprimer</td>
			<td><img src="../../images/refuseModif.png" width="24" height="24"/> : Rejeter</td>
		</tr>
	</table>
	<h5 style="position: relative; top: 35px;">Demandes de validation
		en cours</h5>
	<div id="accordion">
		<h3>

			<a href="#">Demandes non traitées (${dvctap_cree + dctap.modifParEleve})</a>

		</h3>
		<div id="demo">
		
		
		
			<table class="display dataTable">
				<thead>
					<tr class="header">
						<th>Professeurs</th>
						<th>Date</th>
						<th>Temps</th>
						<th>Type d'aide</th>
						<th></th>
						<th></th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${mesdctaps}" var="dctap">
						<c:if test="${dctap.creeeParLeleve or dctap.modifParEleve}">

							<tr>
								<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
								<td>${dctap.dateAction}</td>
								<td><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
								<td>${dctap.accPers.nom}</td>
								<td><a
									href="<c:url value="/app/eleve/edit?id=${dctap.id}" />"><img
										src="../../images/modif.png" width="24" height="24"
										onmouseover="this.src='../../images/modifHover.png';"
										onmouseout="this.src='../../images/modif.png';" /> </a></td>
								<td><a
									href="<c:url value="/app/eleve/delete/${dctap.id}" />"><img
										src="../../images/suppr.png" width="24" height="24"
										onmouseover="this.src='../../images/supprHover.png';"
										onmouseout="this.src='../../images/suppr.png';" /> </a></td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<h3>
			<a href="#">Demandes modifiées par le professeur (${modifie_prof})</a>
		</h3>
		<div id="demo">
			<table class="display dataTable">
				<thead>
					<tr class="header">
						<th>Professeurs</th>
						<th>Date</th>
						<th>Temps</th>
						<th>Type d'aide</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${mesdctaps}" var="dctap">
						<c:if test="${dctap.modifParProf || dctap.dureeModifieProf || dctap.dateModifieProf}">
							<tr>
								<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
								<c:if test="${dctap.dateModifieProf}">
									<td class="isUpdate">${dctap.dateAction}</td>
								</c:if>
								<c:if test="${!dctap.dateModifieProf}">
									<td>${dctap.dateAction}</td>
								</c:if>
								<c:if test="${dctap.dureeModifieProf}">
									<td class="isUpdate"><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
								</c:if>

								<c:if test="${!dctap.dureeModifieProf}">

									<td><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
								</c:if>
								<c:if test="${dctap.modifParProf}">
									<td class="isUpdate">${dctap.accPers.nom}</td>
								</c:if>
								<c:if test="${!dctap.modifParProf}">
									<td>${dctap.accPers.nom}</td>
								</c:if>
								<td><a
									href="<c:url value="/app/eleve/valid/${dctap.id}" />"><img
										src="../../images/valid.png" width="24" height="24"
										onmouseover="this.src='../../images/validHover.png';"
										onmouseout="this.src='../../images/valid.png';" /> </a>
								</td>
								<td><a
									href="<c:url value="/app/eleve/refuse/${dctap.id}" />"><img
										src="../../images/refuseModif.png" width="24" height="24"
										onmouseover="this.src='../../images/refuseModifHover.png';"
										onmouseout="this.src='../../images/refuseModif.png';" /> </a>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<h5>Demandes terminées</h5>
	<div id="accordion2">
		<h3>
			<a href="#">Demandes validées (${dvctap_acceptee_modif_prof + dvctap_validee_prof})</a>
		</h3>
		<div id="demo">
			<table class="display dataTable">
				<thead>
					<tr class="header">
						<th>Professeurs</th>
						<th>Date</th>
						<th>Temps</th>
						<th>Type d'aide</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${mesdctaps}" var="dctap">
						<c:if test="${dctap.accepteEleveApresModifProf or dctap.valideParProf }">
							<tr>
								<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
								<td>${dctap.dateAction}</td>
								<td><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
								<td>${dctap.accPers.nom}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<h3>
			<a href="#">Demandes refusées par le professeur (${dvctap_refus_prof})</a>
		</h3>
		<div id="demo">
			<table class="display dataTable">
				<thead>
					<tr class="header">
						<th>Professeurs</th>
						<th>Date</th>
						<th>Temps</th>
						<th>Type d'aide</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${mesdctaps}" var="dctap">
						<c:if test="${dctap.refuseParProf }">
							<tr>
								<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
								<td>${dctap.dateAction}</td>
								<td><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
								<td>${dctap.accPers.nom}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<h3>
		</h3>
		<div id="demo">
			<table class="display dataTable">
				<thead>
					<tr class="header">
						<th>Professeurs</th>
						<th>Date</th>
						<th>Temps</th>
						<th>Type d'aide</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${mesdctaps}" var="dctap">
						<c:if test="${dctap.rejeteeParLeleve}">
							<tr>
								<td>${dctap.prof.nom} ${dctap.prof.prenom}</td>
								<td>${dctap.dateAction}</td>
								<td><fmt:formatNumber
										value="${(dctap.minutes/60)-((dctap.minutes%60)/60)}"
										pattern="#00" />h<fmt:formatNumber
										value="${dctap.minutes%60}"
										pattern="#00" /></td>
								<td>${dctap.accPers.nom}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
		<c:forEach items="${mesdctaps}" var="dctap">
		<c:set var="timeTT" value="${timeTT + dctap.minutes}" />
		<c:if test="${dctap.accepteEleveApresModifProf or dctap.valideParProf }">
			<c:set var="timeVal" value="${timeVal + dctap.minutes}" />
		</c:if>
	</c:forEach>
	<c:forEach items="${mesdctaps}" var="dctap">
		<c:if test="${rejeteeParLeleve or refuseParProf or annuleeEleve}">
			<c:set var="timeRef" value="${timeRef + dctap.minutes}" />
		</c:if>
	</c:forEach>
	<c:forEach items="${mesdctaps}" var="dctap">
		<c:if

			test="${dctap.creeeParLeleve || dctap.modifParEleve || dctap.dateModifieProf || dctap.dureeModifieProf || dctap.modifParProf}">

			<c:set var="timeAtt" value="${timeAtt + dctap.minutes}" />
		</c:if>
	</c:forEach>
	<br><br>
	<h5>Statistiques</h5>
	<div id="accordion3">
		<h3>
			<a href="#">Mes statistiques</a>
		</h3>
		<table class="display" id="stats">
			<thead>
				<tr>
					<th>Temps total validé</th>
					<th>Temps total en attente</th>
					<th>Temps total refusé</th>
				</tr>
			</thead>
			<tbody>
				<tr>
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
</c:if>

<div class="buttonGroup">
	<a href="<c:url value="/app/eleve/index"/>"><input type="button"
		value="Retour"> </a>
</div>
