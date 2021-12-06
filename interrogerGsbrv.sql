/* Requête SQL pour obtenir le matricule des visiteurs qui occupent
   ou qui ont occupé le poste de délégué régional. */

SELECT vis_matricule
FROM Travailler
WHERE tra_role = 'Délégué';

/* Requête SQL pour obtenir le matricule des visiteurs qui occupent
   actuellement le poste de délégué régional. */

SELECT t.vis_matricule
FROM (SELECT vis_matricule, MAX(jjmmaa) AS MaxDate
      FROM Travailler
      GROUP BY vis_matricule) derniere_date_for_each_visiteur
JOIN Travailler t
ON derniere_date_for_each_visiteur.vis_matricule = t.vis_matricule
AND derniere_date_for_each_visiteur.MaxDate = t.jjmmaa
AND t.tra_role = 'Délégué';

/* Requête SQL pour obtenir les informations relatives au délégué
   régional dont le matricule et le mot de passe sont renseignés. */

SELECT t.vis_matricule, t.tra_role, t.jjmmaa, V.vis_prenom, V.vis_nom
FROM Travailler t
INNER JOIN (SELECT tra_role, vis_matricule, MAX(jjmmaa) AS jjmmaa
            FROM Travailler
            GROUP BY vis_matricule) AS s
INNER JOIN Visiteur AS V
ON s.vis_matricule = t.vis_matricule
AND t.jjmmaa = s.jjmmaa
AND V.vis_matricule = t.vis_matricule
WHERE t.tra_role = 'Délégué'
AND V.vis_matricule = 'c14'
AND V.vis_mdp = 'azerty';

/* Requête pour retourner la liste des praticiens hésitants */

SELECT p.pra_num, p.pra_nom, p.pra_ville, p.pra_coefnotoriete, rv.rap_date_visite, rv.rap_coef_confiance
FROM Praticien p
INNER JOIN (SELECT MAX(rap_date_visite) AS rap_date_visite, MAX(rap_coef_confiance) AS rap_coef_confiance
            FROM RapportVisite
            GROUP BY rap_num ) AS r
INNER JOIN RapportVisite as rv ON p.pra_num = rv.pra_num
WHERE rv.rap_date_visite = r.rap_date_visite
AND rv.rap_coef_confiance = r.rap_coef_confiance
AND rv.rap_coef_confiance < 5;

/* Requête pour obtenir la liste des visiteurs */

SELECT vis_matricule, vis_nom, vis_prenom
FROM Visiteur ;

/* Requête pour obtenir la liste des rapports rédigés par un visiteur, dont on connait le matricule,
   suite aux visites qu'il a effectuées au cours d'un mois connu */

SELECT rv.rap_num, rv.rap_date_visite, rv.rap_date_saisie, rv.rap_bilan, rv.rap_motif, rv.rap_coef_confiance, rv.rap_lu
FROM RapportVisite rv
INNER JOIN Visiteur as v
ON rv.vis_matricule = v.vis_matricule
WHERE v.vis_matricule = "c3"
AND MONTH(rv.rap_date_visite) = 12
AND YEAR(rv.rap_date_visite) = 2021

/* Requête pour enregistrer le fait qu'un rapport dont on connaît le numéro et le rédacteur a été lue */

UPDATE RapportVisite
SET rap_lu = true
WHERE vis_matricule = "a131"
AND rap_num = 1 ;