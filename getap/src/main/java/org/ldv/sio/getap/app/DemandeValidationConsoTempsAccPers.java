package org.ldv.sio.getap.app;

import java.sql.Date;

/**
 * Demande de validation d'un temps d'accompagnement personnalisé
 * 
 * 
 */

public class DemandeValidationConsoTempsAccPers {

	private static final int DVCTAP_CREEE = 0;
	private static final int DVCTAP_ACCEPTEE_MODIF_PROF = 1;
	private static final int DVCTAP_REJETEE = 2;
	private static final int DVCTAP_MODIFIEE_ELEVE = 4;
	private static final int DVCTAP_ANNULEE_ELEVE = 8;
	private static final int DVCTAP_VALIDEE_PROF = 32;
	private static final int DVCTAP_REFUS_PROF = 64;
	private static final int DATE_MODIFIEE = 1024;
	private static final int DUREE_MODIFIEE = 2048;
	private static final int AP_MODIFIEE = 4096;

	/**
	 * Identifiant de la DCTAP
	 */
	private Long id;
	/**
	 * Année scolaire de la demande, par exemple "2011-2012"
	 */
	private String anneeScolaire;
	/**
	 * Date de réalisation de l'accompagnement
	 * 
	 */
	private java.sql.Date dateAction;
	/**
	 * Nombre de minutes d'accompagnement personnalisé à valider
	 */
	private Integer minutes;
	/**
	 * Professeur ayant assuré l'accompagnement personnalisé
	 */
	private User prof;
	/**
	 * Nature de l'accompagnement personnalisé associé à la demande
	 */
	private AccPersonalise accPers;
	/**
	 * Identifiant de l'élève ayant réalisé l'accompagnement personnalisé
	 */
	private User eleve;

	/**
*
*/
	private int etat;

	/**
	 * constructeur par défaut
	 */
	public DemandeValidationConsoTempsAccPers() {

	}

	/**
	 * Constructeur permettant de créer une demande complète.
	 * 
	 * @param id
	 *            peut être null (moment de la creation)
	 * 
	 * @param anneeScolaire
	 * @param date
	 * @param minutes
	 * @param prof
	 * @param accPers
	 * @param eleve
	 * @param etat
	 */
	public DemandeValidationConsoTempsAccPers(Long id, String anneeScolaire,
			Date date, Integer minutes, User prof, AccPersonalise accPers,
			User eleve, int etat) {
		super();
		this.id = id;
		this.anneeScolaire = anneeScolaire;
		this.dateAction = date;
		this.minutes = minutes;
		this.prof = prof;
		this.accPers = accPers;
		this.eleve = eleve;
		this.etat = etat;
	}

	/**
	 * Constructeur permettant d'initialiser l'etat a 0 lors de la creation de
	 * la dvctap
	 * 
	 * 
	 */
	public DemandeValidationConsoTempsAccPers(Long id, String anneeScolaire,
			Date date, Integer minutes, User prof, AccPersonalise accPers,
			User eleve) {
		this(id, anneeScolaire, date, minutes, prof, accPers, eleve, 0);
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAnneeScolaire() {
		return anneeScolaire;
	}

	public void setAnneeScolaire(String anneeScolaire) {
		this.anneeScolaire = anneeScolaire;
	}

	public java.sql.Date getDateAction() {
		return dateAction;
	}

	public void setDateAction(java.sql.Date date) {
		this.dateAction = date;
	}

	public Integer getMinutes() {
		return minutes;
	}

	public void setMinutes(Integer minutes) {
		this.minutes = minutes;
	}

	public User getProf() {
		return prof;
	}

	public void setProf(User prof) {
		this.prof = prof;
	}

	public AccPersonalise getAccPers() {
		return accPers;
	}

	public void setAccPers(AccPersonalise accPers) {
		this.accPers = accPers;
	}

	public User getEleve() {
		return eleve;
	}

	public void setEleve(User eleve) {
		this.eleve = eleve;
	}

	public int getEtat() {
		return etat;
	}

	/**
	 * Permet de modifier l'état de la demande
	 * 
	 * @param etat
	 *            prend ses valeur dans :
	 *            <ul>
	 *            <li>0 - demande créée par l'élève</li>
	 *            <li>1 - demande acceptée par l'élève aprés modification du
	 *            professeur</li>
	 *            <li>2 - demande rejetée par l'élève aprés modification du
	 *            professeur</li>
	 *            <li>4 - demande modifiée par l'élève</li>
	 *            <li>8 - demande annulée par l'élève</li>
	 *            <li>32 - demande validée par le professeur</li>
	 *            <li>64 - demande refusée par le professeur</li>
	 *            <li>1024 - demande où la date a été modifiée par le professeur
	 *            </li>
	 *            <li>2048 - demande où la durée a été modifiée par le
	 *            professeur</li>
	 *            <li>4096 - demande où l'accompagnement personnalisé a été
	 *            modifiée par le professeur</li>
	 *            </ul>
	 */
	public void setEtat(int etat) {
		this.etat = etat;
	}

	@Override
	public String toString() {
		return "DemandeConsoTempsAccPers [id=" + id + ", anneeScolaire="
				+ anneeScolaire + ", dateAction=" + dateAction + ", minutes="
				+ minutes + ", prof=" + prof + ", accPers=" + accPers
				+ ", eleve=" + eleve + ", etat=" + etat + "]";
	}

	public boolean EtatInitial() {
		if (etat == DVCTAP_CREEE) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Methode permettant de passer l'etat a DVCTAP_CREE plus l'etat précedent
	 * 
	 * 
	 */
	public void CreeeParLeleve() {
		if (!this.isAnnuleeEleve() && !this.isRefuseParProf()
				&& !this.isAccepteEleveApresModifProf()
				&& !this.isRejeteeParLeleve() && !this.isValideParProf()
				&& !this.isModifParProf() && !this.isModifParProf()
				&& !this.isDateModifieProf() && !this.isDureeModifieProf()) {
			this.etat = this.etat | DVCTAP_CREEE;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à DVCTAP_PROF plus l'etat précedent
	 * L'etat refuse de changer si sa valeur précédente était
	 * DVCTAP_ANNULEE_ELEVE,
	 * DVCTAP_REFUS_PROF,DVCTAP_REJETEE,DVCTAP_VALIDEE_PROF
	 */
	public void ValideParProf() throws DVCTAPException {
		if (!this.isAnnuleeEleve() && !this.isRefuseParProf()
				&& !this.isRejeteeParLeleve() && !this.isValideParProf()) {
			this.etat = this.etat | DVCTAP_VALIDEE_PROF;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à DVCTAP_REFUS_PROF plus l'etat
	 * précedent
	 * 
	 */
	public void RefuseParProf() throws DVCTAPException {
		if (!this.isAnnuleeEleve() && !this.isValideParProf()
				&& !this.isAccepteEleveApresModifProf()
				&& !this.isRejeteeParLeleve() && !this.isRefuseParProf()) {
			this.etat = this.etat | DVCTAP_REFUS_PROF;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à DVCTAP_ANNULEE_ELEVE plus l'etat
	 * précedent
	 * 
	 */
	public void AnnuleeEleve() throws DVCTAPException {
		if (!this.isValideParProf() && !this.isRefuseParProf()
				&& !this.isAccepteEleveApresModifProf()
				&& !this.isRejeteeParLeleve() && !this.isModifParProf()
				&& !this.isDureeModifieProf() && !this.isDateModifieProf()
				&& !this.isAnnuleeEleve()) {
			this.etat = this.etat | DVCTAP_ANNULEE_ELEVE;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à DVCTAP_MODIFIEE_ELEVE plus l'etat
	 * précedent
	 * 
	 */
	public void modifieeParEleve() throws DVCTAPException {
		if (!this.isValideParProf() && !this.isRefuseParProf()
				&& !this.isAccepteEleveApresModifProf()
				&& !this.isRejeteeParLeleve() && !this.isModifParProf()
				&& !this.isDureeModifieProf() && !this.isDateModifieProf()
				&& !this.isAnnuleeEleve()) {
			this.etat = this.etat | DVCTAP_MODIFIEE_ELEVE;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à DATE_MODIFIEE plus l'etat précedent
	 * 
	 */
	public void DateModifieProf() throws DVCTAPException {
		if (!this.isValideParProf() && !this.isRefuseParProf()
				&& !this.isAccepteEleveApresModifProf()
				&& !this.isRejeteeParLeleve() && !this.isAnnuleeEleve()
				&& !this.isRefuseParProf() && !this.isValideParProf()) {
			this.etat = this.etat | DATE_MODIFIEE;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à DUREE_MODIFIEE plus l'etat
	 * précedent
	 * 
	 */
	public void modifieeDureeParLeProfesseur() throws DVCTAPException {
		if (!this.isValideParProf() && !this.isRefuseParProf()
				&& !this.isAccepteEleveApresModifProf()
				&& !this.isRejeteeParLeleve() && !this.isAnnuleeEleve()
				&& !this.isRefuseParProf() && !this.isValideParProf()) {
			this.etat = this.etat | DUREE_MODIFIEE;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à AP_MODIFIEE plus l'etat précedent
	 * 
	 */
	public void modifieeAPParLeProfesseur() throws DVCTAPException {
		if (!this.isValideParProf() && !this.isRefuseParProf()
				&& !this.isAccepteEleveApresModifProf()
				&& !this.isRejeteeParLeleve() && !this.isAnnuleeEleve()
				&& !this.isRefuseParProf() && !this.isValideParProf()) {
			this.etat = this.etat | AP_MODIFIEE;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à DVCTAP_REJETEE plus l'etat
	 * précedent
	 * 
	 */
	public void RejeteeParLeleve() throws DVCTAPException {
		if (!this.isValideParProf()
				&& !this.isRefuseParProf()
				&& !this.isRejeteeParLeleve()
				&& !this.isAnnuleeEleve()
				&& !this.isRefuseParProf()
				&& !this.isValideParProf()
				&& !this.isRejeteeParLeleve()
				&& (this.isModifParProf() || this.isDateModifieProf() || this
						.isDureeModifieProf())) {
			this.etat = this.etat | DVCTAP_REJETEE;
		} else {
			throw new DVCTAPException("Erreur lors du changement de l'état !");
		}
	}

	/**
	 * Methode permettant de passer l'état à DVCTAP_ACCEPTEE_MODIF_PROF plus
	 * l'etat précedent
	 * 
	 */
	public boolean AccepteEleveApresModifProf() throws DVCTAPException {
		boolean verif = true;
		if (!this.isValideParProf()
				&& !this.isRefuseParProf()
				&& !this.isRejeteeParLeleve()
				&& !this.isAnnuleeEleve()
				&& !this.isRefuseParProf()
				&& !this.isValideParProf()
				&& !this.isAccepteEleveApresModifProf()
				&& (this.isModifParProf() || this.isDateModifieProf() || this
						.isDureeModifieProf())) {
			this.etat = this.etat | DVCTAP_ACCEPTEE_MODIF_PROF;
			verif = true;
		} else {
			System.out.println("Erreur lors du changement de l'état !");
			verif = false;
		}
		return verif;
	}

	/**
	 * Methodes permettant de verifier la valeur de l'etat. L'etat initial avec
	 * le changement de DVCTAP ne doit pas valoir 0 sauf lors de la création de
	 * la demande.
	 * 
	 * 
	 */

	public boolean isCreeeParLeleve() {
		boolean isCreee = (this.etat & DVCTAP_CREEE) == 0;
		return isCreee;
	}

	public boolean isAccepteEleveApresModifProf() {
		boolean isAccepteeEleve = (this.etat & DVCTAP_ACCEPTEE_MODIF_PROF) != 0;
		return isAccepteeEleve;
	}

	public boolean isRejeteeParLeleve() {
		boolean isRejetee = (this.etat & DVCTAP_REJETEE) != 0;
		return isRejetee;
	}

	public boolean isModifParEleve() {
		boolean isModifEleve = (this.etat & DVCTAP_MODIFIEE_ELEVE) != 0;
		return isModifEleve;
	}

	public boolean isAnnuleeEleve() {
		boolean isAnnuleeEleve = (this.etat & DVCTAP_ANNULEE_ELEVE) != 0;
		return isAnnuleeEleve;
	}

	public boolean isValideParProf() {
		boolean isValideProf = (this.etat & DVCTAP_VALIDEE_PROF) != 0;
		return isValideProf;
	}

	public boolean isRefuseParProf() {
		boolean isRefusProf = (this.etat & DVCTAP_REFUS_PROF) != 0;
		return isRefusProf;
	}

	public boolean isDateModifieProf() {
		boolean isDateModifProf = (this.etat & DATE_MODIFIEE) != 0;
		return isDateModifProf;
	}

	public boolean isDureeModifieProf() {
		boolean isDureeModifProf = (this.etat & DUREE_MODIFIEE) != 0;
		return isDureeModifProf;
	}

	public boolean isModifParProf() {
		boolean isModifParProf = (this.etat & AP_MODIFIEE) != 0;
		return isModifParProf;
	}

}
