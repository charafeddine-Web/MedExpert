<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.medexpert.model.Patient" %>
<%@ page import="org.example.medexpert.model.SigneVital" %>
<%@ page import="org.example.medexpert.dao.SigneVitalDAO" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Infirmier - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function toggleForm() {
            const formSection = document.getElementById("formulaire");
            formSection.classList.toggle("hidden");
            window.scrollTo({ top: 0, behavior: "smooth" });
        }
    </script>
</head>
<body class="bg-gray-100 min-h-screen w-full">
<div class="flex w-full min-h-screen">

    <nav class="w-64 bg-blue-900 text-white flex flex-col items-center py-10 min-h-screen">
        <h2 class="text-2xl font-bold mb-10 tracking-wide">Module Infirmier</h2>
        <ul class="w-full space-y-2">
            <li>
                <button onclick="toggleForm()" class="w-full text-left px-6 py-3 rounded-lg hover:bg-blue-800 transition">
                    ➕ Ajouter un patient
                </button>
            </li>
            <li>
                <a href="#liste" class="block px-6 py-3 rounded-lg hover:bg-blue-800 transition">Patients du jour</a>
            </li>
        </ul>
        <div class="mt-auto text-xs text-blue-200 pt-10">
            © <%= java.time.Year.now() %> MedExpert
        </div>
    </nav>

    <main class="flex-1 p-6 bg-gray-100 min-h-screen">

        <div class="max-w-3xl mx-auto mb-6">
            <%
                String infoMessage = (String) request.getAttribute("infoMessage");
                String successMessage = (String) request.getAttribute("successMessage");
                if (infoMessage != null) {
            %>
            <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-4">
                <%= infoMessage %>
            </div>
            <% } %>
            <% if (successMessage != null) { %>
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4">
                <%= successMessage %>
            </div>
            <% } %>
        </div>



        <section id="formulaire" class="w-full flex flex-col items-center py-10 hidden">
            <h3 class="text-xl font-bold text-blue-700 mb-6">Enregistrer un patient</h3>
            <%
                Patient patientExistant = (Patient) request.getAttribute("patientExistant");
            %>
            <form action="<%=request.getContextPath()%>/infirmier" method="post" class="bg-white shadow-md rounded-xl w-full max-w-3xl p-8 grid grid-cols-1 md:grid-cols-2 gap-6">

                <% if (patientExistant != null) { %>
                <h4 class="text-lg font-semibold text-blue-700 col-span-full mb-4">Patient existant</h4>
                <input type="text" name="nom" value="<%=patientExistant.getNom()%>" readonly class="bg-gray-100 border rounded px-4 py-2" />
                <input type="text" name="prenom" value="<%=patientExistant.getPrenom()%>" readonly class="bg-gray-100 border rounded px-4 py-2" />
                <input type="text" name="numSecuriteSociale" value="<%=patientExistant.getNumSecuriteSociale()%>" readonly class="bg-gray-100 border rounded px-4 py-2" />

                <h4 class="text-lg font-semibold text-blue-700 col-span-full mt-4 mb-2">Ajouter de nouveaux signes vitaux</h4>
                <input type="number" step="0.1" name="tension" placeholder="Tension" required class="border rounded px-4 py-2" />
                <input type="number" step="1" name="frequenceCardiaque" placeholder="Fréquence cardiaque" required class="border rounded px-4 py-2" />
                <input type="number" step="0.1" name="temperature" placeholder="Température" required class="border rounded px-4 py-2" />
                <input type="number" step="1" name="frequenceRespiratoire" placeholder="Fréquence respiratoire" required class="border rounded px-4 py-2" />
                <input type="number" step="0.1" name="poids" placeholder="Poids" required class="border rounded px-4 py-2" />
                <input type="number" step="1" name="taille" placeholder="Taille" required class="border rounded px-4 py-2" />

                <% } else { %>
                <h4 class="text-lg font-semibold text-blue-700 col-span-full mb-4">Nouveau patient</h4>
                <input type="text" name="nom" placeholder="Nom" required class="border rounded px-4 py-2" />
                <input type="text" name="prenom" placeholder="Prénom" required class="border rounded px-4 py-2" />
                <input type="text" name="numSecuriteSociale" placeholder="Numéro sécurité sociale" required class="border rounded px-4 py-2" />
                <input type="text" name="adresse" placeholder="Adresse" class="border rounded px-4 py-2" />
                <input type="text" name="mutuelle" placeholder="Mutuelle" class="border rounded px-4 py-2" />

                <textarea name="antecedents" placeholder="Antécédents médicaux" required class="border rounded px-4 py-2 md:col-span-2"></textarea>

                <textarea name="allergies" placeholder="Allergies" required class="border rounded px-4 py-2 md:col-span-2"></textarea>

                <textarea name="traitementsEnCours" placeholder="Traitements en cours" required class="border rounded px-4 py-2 md:col-span-2"></textarea>

                <h4 class="text-lg font-semibold text-blue-700 col-span-full mt-4 mb-2">Signes vitaux</h4>
                <input type="number" step="0.1" name="tension" placeholder="Tension" required class="border rounded px-4 py-2" />
                <input type="number" step="1" name="frequenceCardiaque" placeholder="Fréquence cardiaque" required class="border rounded px-4 py-2" />
                <input type="number" step="0.1" name="temperature" placeholder="Température" required class="border rounded px-4 py-2" />
                <input type="number" step="1" name="frequenceRespiratoire" placeholder="Fréquence respiratoire" required class="border rounded px-4 py-2" />
                <input type="number" step="0.1" name="poids" placeholder="Poids" required class="border rounded px-4 py-2" />
                <input type="number" step="1" name="taille" placeholder="Taille" required class="border rounded px-4 py-2" />
                <% } %>

                <div class="col-span-1 md:col-span-2 flex justify-end mt-4">
                    <button type="submit" class="bg-blue-700 hover:bg-blue-800 text-white font-bold py-3 px-8 rounded w-full md:w-auto">Enregistrer</button>
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
                        <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Date d'arrivée</th>
                        <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Adresse</th>
                        <th class="px-6 py-3 bg-blue-50 text-blue-900 font-semibold text-left">Mutuelle</th>

                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Patient> patientsDuJour = (List<Patient>) request.getAttribute("patientsDuJour");
                        SigneVitalDAO signeVitalDAO = new SigneVitalDAO();
                        if (patientsDuJour != null && !patientsDuJour.isEmpty()) {
                            for (Patient p : patientsDuJour) {
                    %>
                    <tr class="border-b hover:bg-blue-50">
                        <td class="px-6 py-4"><%= p.getNom() %></td>
                        <td class="px-6 py-4"><%= p.getPrenom() %></td>
                        <td class="px-6 py-4"><%= p.getDateArrivee() %></td>
                        <td class="px-6 py-4"><%= p.getAdresse() %></td>
                        <td class="px-6 py-4"><%= p.getMutuelle() %></td>

                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center py-8 text-gray-400">
                            Aucun patient enregistré aujourd'hui.
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </section>

    </main>
</div>
</body>
</html>
