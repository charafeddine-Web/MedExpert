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
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        .input-modern {
            transition: all 0.3s ease;
        }

        .input-modern:focus {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
        }

        .nav-item {
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: white;
            transform: scaleY(0);
            transition: transform 0.3s ease;
        }

        .nav-item:hover::before {
            transform: scaleY(1);
        }

        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .slide-in {
            animation: slideIn 0.4s ease-out;
        }

        @keyframes slideIn {
            from { transform: translateX(-100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .table-row-hover {
            transition: all 0.2s ease;
        }

        .table-row-hover:hover {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            transform: scale(1.01);
        }
    </style>
    <script>
        function toggleForm() {
            const formSection = document.getElementById("formulaire");
            formSection.classList.toggle("hidden");
            window.scrollTo({ top: 0, behavior: "smooth" });
        }
        setTimeout(() => {
            const info = document.getElementById('messageInfo');
            if(info) info.style.display = 'none';

            const success = document.getElementById('messageSuccess');
            if(success) success.style.display = 'none';
        }, 5000);
    </script>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
<div class="flex w-full min-h-screen">

    <nav class="w-72 gradient-bg text-white flex flex-col shadow-2xl slide-in lg:relative fixed z-50 h-screen">
        <div class="p-8">
            <div class="flex items-center space-x-3 mb-8">
                <div class="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center backdrop-blur-sm">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                </div>
                <div>
                    <h2 class="text-2xl font-bold tracking-tight">MedExpert</h2>
                    <p class="text-xs text-white/70">Module Infirmier</p>
                </div>
            </div>
        </div>

        <ul class="flex-1 px-4 space-y-2">
            <li>
                <button onclick="toggleForm()" class="nav-item w-full text-left px-6 py-4 rounded-xl hover:bg-white/10 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-white/10 rounded-lg flex items-center justify-center group-hover:bg-white/20 transition">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                    </div>
                    <span class="font-medium">Ajouter un patient</span>
                </button>
            </li>
            <li>
                <a href="#liste" class="nav-item block px-6 py-4 rounded-xl hover:bg-white/10 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-white/10 rounded-lg flex items-center justify-center group-hover:bg-white/20 transition">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                    </div>
                    <span class="font-medium">Patients du jour</span>
                </a>
            </li>
            <li>
                <a href="#liste" class="nav-item block px-6 py-4 rounded-xl hover:bg-white/10 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-white/10 rounded-lg flex items-center justify-center group-hover:bg-white/20 transition">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                    </div>
                    <form action="<%request.getContextPath();%>/logout" method="POST" class="inline">
                    <span class="font-medium">Déconnexion</span>
                    </form>
                </a>
            </li>
        </ul>

        <div class="p-6 border-t border-white/10">
            <p class="text-xs text-white/50 text-center">© <%= java.time.Year.now() %> MedExpert</p>
        </div>
    </nav>

    <main class="flex-1 p-4 lg:p-8 overflow-auto">

        <div class="max-w-6xl mx-auto mb-6 fade-in">
            <%
                String infoMessage = (String) request.getAttribute("infoMessage");
                String successMessage = (String) request.getAttribute("successMessage");
                if (infoMessage != null) {
            %>
            <div id="messageInfo" class="glass-effect border-l-4 border-yellow-400 text-yellow-800 p-5 rounded-xl shadow-lg mb-4 flex items-start space-x-3">
                <svg class="w-6 h-6 text-yellow-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                </svg>
                <span><%= infoMessage %></span>
            </div>
            <% } %>
            <% if (successMessage != null) { %>
            <div id="messageSuccess" class="glass-effect border-l-4 border-green-400 text-green-800 p-5 rounded-xl shadow-lg mb-4 flex items-start space-x-3">
                <svg class="w-6 h-6 text-green-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                </svg>
                <span><%= successMessage %></span>
            </div>
            <% } %>
        </div>

        <section id="formulaire" class="w-full max-w-6xl mx-auto py-10 hidden fade-in">
            <div class="glass-effect rounded-2xl shadow-2xl p-8 lg:p-12 card-hover">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                    </div>
                    <h3 class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-indigo-600 bg-clip-text text-transparent">Enregistrer un patient</h3>
                </div>

                <%
                    Patient patientExistant = (Patient) request.getAttribute("patientExistant");
                %>
                <form action="<%=request.getContextPath()%>/infirmier" method="post" class="grid grid-cols-1 lg:grid-cols-2 gap-6">

                    <% if (patientExistant != null) { %>
                    <div class="col-span-full">
                        <h4 class="text-xl font-semibold text-gray-800 mb-6 flex items-center">
                            <span class="w-1 h-6 bg-gradient-to-b from-purple-500 to-indigo-500 rounded-full mr-3"></span>
                            Patient existant
                        </h4>
                    </div>
                    <input type="text" name="nom" value="<%=patientExistant.getNom()%>" readonly class="bg-gray-50 border-2 border-gray-200 rounded-xl px-5 py-3.5 text-gray-600 font-medium" />
                    <input type="text" name="prenom" value="<%=patientExistant.getPrenom()%>" readonly class="bg-gray-50 border-2 border-gray-200 rounded-xl px-5 py-3.5 text-gray-600 font-medium" />
                    <input type="text" name="numSecuriteSociale" value="<%=patientExistant.getNumSecuriteSociale()%>" readonly class="bg-gray-50 border-2 border-gray-200 rounded-xl px-5 py-3.5 text-gray-600 font-medium lg:col-span-2" />

                    <div class="col-span-full mt-6">
                        <h4 class="text-xl font-semibold text-gray-800 mb-6 flex items-center">
                            <span class="w-1 h-6 bg-gradient-to-b from-purple-500 to-indigo-500 rounded-full mr-3"></span>
                            Ajouter de nouveaux signes vitaux
                        </h4>
                    </div>
                    <input type="number" step="0.1" name="tension" placeholder="Tension" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="1" name="frequenceCardiaque" placeholder="Fréquence cardiaque" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="0.1" name="temperature" placeholder="Température" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="1" name="frequenceRespiratoire" placeholder="Fréquence respiratoire" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="0.1" name="poids" placeholder="Poids" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="1" name="taille" placeholder="Taille" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />

                    <% } else { %>
                    <div class="col-span-full">
                        <h4 class="text-xl font-semibold text-gray-800 mb-6 flex items-center">
                            <span class="w-1 h-6 bg-gradient-to-b from-purple-500 to-indigo-500 rounded-full mr-3"></span>
                            Nouveau patient
                        </h4>
                    </div>
                    <input type="text" name="nom" placeholder="Nom" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="text" name="prenom" placeholder="Prénom" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="text" name="numSecuriteSociale" placeholder="Numéro sécurité sociale" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="text" name="adresse" placeholder="Adresse" class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="text" name="mutuelle" placeholder="Mutuelle" class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none lg:col-span-2" />

                    <textarea name="antecedents" placeholder="Antécédents médicaux" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none lg:col-span-2 min-h-[100px]"></textarea>

                    <textarea name="allergies" placeholder="Allergies" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none lg:col-span-2 min-h-[100px]"></textarea>

                    <textarea name="traitementsEnCours" placeholder="Traitements en cours" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none lg:col-span-2 min-h-[100px]"></textarea>

                    <div class="col-span-full mt-6">
                        <h4 class="text-xl font-semibold text-gray-800 mb-6 flex items-center">
                            <span class="w-1 h-6 bg-gradient-to-b from-purple-500 to-indigo-500 rounded-full mr-3"></span>
                            Signes vitaux
                        </h4>
                    </div>
                    <input type="number" step="0.1" name="tension" placeholder="Tension" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="1" name="frequenceCardiaque" placeholder="Fréquence cardiaque" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="0.1" name="temperature" placeholder="Température" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="1" name="frequenceRespiratoire" placeholder="Fréquence respiratoire" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="0.1" name="poids" placeholder="Poids" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <input type="number" step="1" name="taille" placeholder="Taille" required class="input-modern border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                    <% } %>

                    <div class="col-span-full flex justify-end mt-6">
                        <button type="submit" class="gradient-bg hover:opacity-90 text-white font-bold py-4 px-10 rounded-xl shadow-lg transition transform hover:scale-105 flex items-center space-x-2">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                            <span>Enregistrer</span>
                        </button>
                    </div>
                </form>
            </div>
        </section>

        <section id="liste" class="w-full max-w-6xl mx-auto py-10 fade-in">
            <div class="glass-effect rounded-2xl shadow-2xl p-8 card-hover">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                    </div>
                    <h3 class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-indigo-600 bg-clip-text text-transparent">Patients du jour</h3>
                </div>

                <div class="overflow-x-auto rounded-xl">
                    <table class="min-w-full">
                        <thead>
                        <tr class="border-b-2 border-gray-200">
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Nom</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Prénom</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Date d'arrivée</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Adresse</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Mutuelle</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                        <%
                            List<Patient> patientsDuJour = (List<Patient>) request.getAttribute("patientsDuJour");
                            SigneVitalDAO signeVitalDAO = new SigneVitalDAO();
                            if (patientsDuJour != null && !patientsDuJour.isEmpty()) {
                                for (Patient p : patientsDuJour) {
                        %>
                        <tr class="table-row-hover">
                            <td class="px-6 py-4 text-gray-800 font-medium"><%= p.getNom() %></td>
                            <td class="px-6 py-4 text-gray-800"><%= p.getPrenom() %></td>
                            <td class="px-6 py-4 text-gray-600"><%= p.getDateArrivee() %></td>
                            <td class="px-6 py-4 text-gray-600"><%= p.getAdresse() %></td>
                            <td class="px-6 py-4 text-gray-600"><%= p.getMutuelle() %></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center py-12">
                                <svg class="w-16 h-16 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"/>
                                </svg>
                                <p class="text-gray-400 text-lg font-medium">Aucun patient enregistré aujourd'hui</p>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

    </main>
</div>
</body>
</html>