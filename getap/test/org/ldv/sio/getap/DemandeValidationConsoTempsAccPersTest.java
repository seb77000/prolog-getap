package org.ldv.sio.getap;

import java.sql.Date;

import junit.framework.TestCase;

import org.junit.Before;
import org.junit.Test;
import org.ldv.sio.getap.app.AccPersonalise;
import org.ldv.sio.getap.app.Classe;
import org.ldv.sio.getap.app.DVCTAPException;
import org.ldv.sio.getap.app.DemandeValidationConsoTempsAccPers;
import org.ldv.sio.getap.app.User;

public class DemandeValidationConsoTempsAccPersTest extends TestCase {

	private DemandeValidationConsoTempsAccPers dvctap;

	/**
	 * Initialisation de dvctap
	 */
	@Before
	public void setUp() throws Exception {
		Classe classe = new Classe(1, "SIO 22");
		User eleve = new User(01L, "Nizar", "Ben Ragdel", classe, "eleve");
		User prof = new User(02L, "Olivier", "Capuozzo", classe, "professeur");
		Date date = Date.valueOf("2012-10-07");
		AccPersonalise accPers = new AccPersonalise(0, "Salon du libre", 0, 02L);

		dvctap = new DemandeValidationConsoTempsAccPers(01L, "2012-2013", date,
				240, prof, accPers, eleve);
	}

	/**
	 * Test permettant de verifier le bon fonctionnement lors changement de la
	 * dvctap apres la modification du professeur
	 */
	@Test
	public void testAccepteEleveApresModifProf() {

		try {
			dvctap.creeeParLeleve();
			dvctap.dateModifieProf();
			dvctap.accepteEleveApresModifProf();

		} catch (DVCTAPException e) {
			throw new DVCTAPException("Changement impossible");
		}
	}

	/**
	 * Test permettant de verifier si la modification de la date par le
	 * professeur fonctionne.
	 */
	public void testModifProf() {
		try {
			dvctap.creeeParLeleve();
			dvctap.dateModifieProf();

		}

		catch (DVCTAPException e) {

			throw new DVCTAPException("Changement impossible");

		}

	}

	/**
	 * Test permettant de verifier si une dvctap peu etre valide par le
	 * professeur.
	 */
	public void testValide() {
		try {
			dvctap.creeeParLeleve();
			dvctap.modifieeAPParLeProfesseur();
			dvctap.dateModifieProf();
			dvctap.accepteEleveApresModifProf();
			dvctap.isDureeModifieProf();
			dvctap.valideParProf();

		}

		catch (DVCTAPException e) {

			throw new DVCTAPException("Changement impossible");

		}
	}

	/**
	 * Test permettant de verifier si le refus d'une dvctap par un professeur
	 * est possible.
	 */
	public void testRefusProf() {
		try {
			dvctap.creeeParLeleve();
			dvctap.refuseParProf();

		}

		catch (DVCTAPException e) {

			throw new DVCTAPException("Changement impossible");

		}
	}

	/**
	 * Test permettant de verifier si l'élève peu annule sa demande
	 */
	public void testAnnuleParEleve() {
		try {
			dvctap.creeeParLeleve();
			dvctap.annuleeEleve();

		}

		catch (DVCTAPException e) {

			throw new DVCTAPException("Changement impossible");

		}
	}

	/**
	 * Test permettant de verifier si l'utilisateur peu rejete une demande.
	 */
	public void testRejete() {
		try {
			dvctap.creeeParLeleve();
			dvctap.dateModifieProf();
			dvctap.rejeteeParLeleve();

		}

		catch (DVCTAPException e) {

			throw new DVCTAPException("Changement impossible");

		}
	}

	/**
	 * Test permettant de montrer que l'élève ne peut annulé accepté une demande
	 * modifer par le professeur apres l'avoir annulé.
	 * 
	 */
	@Test
	public void testAccepteEleveApresModifProfNonValide() {

		try {
			dvctap.creeeParLeleve();
			dvctap.dateModifieProf();
			dvctap.annuleeEleve();
			dvctap.accepteEleveApresModifProf();

		} catch (DVCTAPException e) {
			throw new DVCTAPException("Changement impossible");
		}
	}

	/**
	 * Test permettant de montrer que l'élève ne peut pas annuler une demande
	 * qui a déja été validé par le professeur.
	 */
	public void testAnnuleParEleveNonValide() {
		try {
			dvctap.creeeParLeleve();
			dvctap.valideParProf();
			dvctap.annuleeEleve();

		}

		catch (DVCTAPException e) {

			throw new DVCTAPException("Changement impossible");

		}
	}
}
