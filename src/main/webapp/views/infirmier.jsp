<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.medexpert.model.Patient" %>
<%@ page import="org.example.medexpert.model.SigneVital" %>
<%@ page import="org.example.medexpert.model.enums.StatutConsultation" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Infirmier - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.4.1/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen w-full">
<div class="flex w-full min-h-screen">
    <!-- Sidebar -->
    <nav class="w-64 bg-blue-900 text-white flex flex-col items-center py-10 min-h-screen">
        <h2 class="text-2xl font-bold mb-10 tracking-wide">Module Infirmier</h2>
        <ul class="w-full space-y-2">
            <li><a href="#enregistrer" class="block px-6 py-3 rounded-lg hover:bg-blue-800 transition">Enregistrer un patient</a></li>
            <li><a href="#liste" class="block px-6 py-3 rounded-lg hover:bg-blue-800 transition">Patients du jour</a></li>
            <li><a href="#statuts" class="block px-6 py-3 rounded-lg hover:bg-blue-800 transition">Statuts en temps réel</a></li>
        </ul>
        <div class="mt-auto text-xs text-blue-200 pt-10">© <%= java.time.Year.now() %> MedExpert</div>
    </nav>
    <!-- Main content -->
    <main class="flex-1 p-0 md:p-0 bg-gray-100 min-h-screen">
        <section id="enregistrer" class="w-full flex flex-col items-center py-10">
            <h3 class="text-xl font-bold text-blue-700 mb-6">Enregistrer un patient</h3>
            <form action="<%=request.getContextPath()%>/infirmier" method="post" class="bg-white shadow-md rounded-xl w-full max-w-3xl p-8 grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="flex flex-col gap-4">
                    <input type="text" name="nom" placeholder="Nom du patient" required class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="text" name="prenom" placeholder="Prénom du patient" required class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="date" name="dateArrivee" placeholder="Date de naissance" required class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="text" name="adresse" placeholder="Adresse" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="text" name="numSecuriteSociale" placeholder="Numéro Sécurité Sociale" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="text" name="mutuelle" placeholder="Mutuelle (Oui/Non)" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                </div>
                <div class="flex flex-col gap-4">
                    <input type="text" name="antecedents" placeholder="Antécédents médicaux" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="text" name="allergies" placeholder="Allergies" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="text" name="traitementsEnCours" placeholder="Traitements en cours" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="number" step="0.1" name="temperature" placeholder="Température (°C)" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="number" step="1" name="frequenceCardiaque" placeholder="Fréquence cardiaque (bpm)" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="number" step="1" name="tension" placeholder="Tension (mmHg)" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <input type="number" step="1" name="frequenceRespiratoire" placeholder="Fréquence respiratoire (/min)" class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                </div>
                <div class="col-span-1 md:col-span-2 flex justify-end">
                    <button type="submit" class="bg-blue-700 hover:bg-blue-800 text-white font-bold py-3 px-8 rounded-lg transition">Enregistrer</button>
                </div>
            </form>
        </section>
        <section id="liste" class="w-full flex flex-col items-center py-10">
            <h3 class="text-xl font-bold text-blue-700 mb-6">Patients du jour</h3>
            <div class="w-full max-w-5xl overflow-x-auto rounded-xl shadow">
                <table class="min-w-full bg-white rounded-xl">
                    <thead>
                        <tr>
                            <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Nom</th>
                            <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Prénom</th>
                            <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Date de naissance</th>
                            <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Température</th>
                            <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">FC</th>
                            <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Tension</th>
                            <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">FR</th>
                            <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% List<Patient> patientsDuJour = (List<Patient>) request.getAttribute("patientsDuJour");
                       if (patientsDuJour != null && !patientsDuJour.isEmpty()) {
                           for (Patient p : patientsDuJour) { SigneVital sv = (SigneVital) p.getSignesVitaux(); %>
                        <tr class="border-b hover:bg-blue-50">
                            <td class="px-6 py-4"><%= p.getNom() %></td>
                            <td class="px-6 py-4"><%= p.getPrenom() %></td>
                            <td class="px-6 py-4"><%= p.getDateArrivee() %></td>
                            <td class="px-6 py-4"><%= sv != null ? sv.getTemperature() + "°C" : "-" %></td>
                            <td class="px-6 py-4"><%= sv != null ? sv.getFrequenceCardiaque() : "-" %></td>
                            <td class="px-6 py-4"><%= sv != null ? sv.getTension() : "-" %></td>
                            <td class="px-6 py-4"><%= sv != null ? sv.getFrequenceRespiratoire() : "-" %></td>
                            <td class="px-6 py-4">-</td>
                        </tr>
                    <%   }
                       } else { %>
                        <tr><td colspan="8" class="text-center py-8 text-gray-400">Aucun patient enregistré aujourd'hui.</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>
</body>
</html>
