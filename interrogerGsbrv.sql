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

SELECT *
FROM Praticien ;
