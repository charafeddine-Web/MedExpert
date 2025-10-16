<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.medexpert.model.Patient" %>
<%@ page import="org.example.medexpert.model.Consultation" %>
<%@ page import="org.example.medexpert.model.Utilisateur" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Médecin Généraliste - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .gradient-bg-alt {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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

        .badge {
            display: inline-flex;
            align-items: center;
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            transition: all 0.2s;
        }

        .badge-warning {
            background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
            color: white;
        }

        .badge-success {
            background: linear-gradient(135deg, #34d399 0%, #10b981 100%);
            color: white;
        }

        .stats-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            border-radius: 1rem;
            padding: 1.5rem;
            transition: all 0.3s;
        }

        .stats-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
    </style>
    <script>

        function toggleSection(sectionId) {
            const sections = ['patients-attente', 'consultation-form', 'actes-form'];
            sections.forEach(id => {
                const section = document.getElementById(id);
                if (section) {
                    section.classList.add('hidden');
                }
            });
            const section = document.getElementById(sectionId);
            if (section) section.classList.remove('hidden');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function openConsultationForm(patientId, patientNom, patientPrenom) {
            document.getElementById('patientId').value = patientId;
            document.getElementById('patientInfo').textContent = patientNom + ' ' + patientPrenom;
            toggleSection('consultation-form');
        }

        function openActesForm(consultationId) {
            document.getElementById('consultationId').value = consultationId;
            toggleSection('actes-form');
        }

        setTimeout(() => {
            const messages = document.querySelectorAll('[id^="message"]');
            messages.forEach(msg => {
                if (msg) msg.style.display = 'none';
            });
        }, 5000);
    </script>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
<%
    HttpSession sessionUser = request.getSession(false);
    Utilisateur user = (Utilisateur) (sessionUser != null ? sessionUser.getAttribute("user") : null);
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }
%>

<div class="flex w-full min-h-screen">
    <!-- Sidebar Navigation -->
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
                    <p class="text-xs text-white/70">Médecin Généraliste</p>
                </div>
            </div>

            <div class="bg-white/10 rounded-xl p-4 backdrop-blur-sm">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm font-semibold"><%= user.getPrenom() %> <%= user.getNom() %></p>
                        <p class="text-xs text-white/70"><%= user.getRole() %></p>
                    </div>
                </div>
            </div>
        </div>

        <ul class="flex-1 px-4 space-y-2">
            <li>
                <button onclick="toggleSection('patients-attente')" class="nav-item w-full text-left px-6 py-4 rounded-xl hover:bg-white/10 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-white/10 rounded-lg flex items-center justify-center group-hover:bg-white/20 transition">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                    </div>
                    <span class="font-medium">Patients en attente</span>
                </button>
            </li>
            <li>
                <button onclick="toggleSection('consultation-form')" class="nav-item w-full text-left px-6 py-4 rounded-xl hover:bg-white/10 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-white/10 rounded-lg flex items-center justify-center group-hover:bg-white/20 transition">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <span class="font-medium">Nouvelle consultation</span>
                </button>
            </li>
            <li>
                <button onclick="toggleSection('actes-form')" class="nav-item w-full text-left px-6 py-4 rounded-xl hover:bg-white/10 transition flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-white/10 rounded-lg flex items-center justify-center group-hover:bg-white/20 transition">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                    </div>
                    <span class="font-medium">Ajouter actes techniques</span>
                </button>
            </li>
            <li>
                <form action="<%=request.getContextPath()%>/logout" method="POST" class="w-full">
                    <button type="submit" class="nav-item w-full text-left px-6 py-4 rounded-xl hover:bg-white/10 transition flex items-center space-x-3 group">
                        <div class="w-10 h-10 bg-white/10 rounded-lg flex items-center justify-center group-hover:bg-white/20 transition">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                            </svg>
                        </div>
                        <span class="font-medium">Déconnexion</span>
                    </button>
                </form>
            </li>
        </ul>

        <div class="p-6 border-t border-white/10">
            <p class="text-xs text-white/50 text-center">© <%= java.time.Year.now() %> MedExpert</p>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="flex-1 p-4 lg:p-8 overflow-auto">
        <!-- Messages -->
        <div class="max-w-7xl mx-auto mb-6 fade-in">
            <%
                String infoMessage = (String) request.getAttribute("infoMessage");
                String successMessage = (String) request.getAttribute("successMessage");
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (infoMessage != null) {
            %>
            <div id="messageInfo" class="glass-effect border-l-4 border-blue-400 text-blue-800 p-5 rounded-xl shadow-lg mb-4 flex items-start space-x-3">
                <svg class="w-6 h-6 text-blue-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
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
            <% if (errorMessage != null) { %>
            <div id="messageError" class="glass-effect border-l-4 border-red-400 text-red-800 p-5 rounded-xl shadow-lg mb-4 flex items-start space-x-3">
                <svg class="w-6 h-6 text-red-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                </svg>
                <span><%= errorMessage %></span>
            </div>
            <% } %>
        </div>

        <!-- Statistics Cards -->
        <div class="max-w-7xl mx-auto mb-8 fade-in">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="stats-card">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600 mb-1">Patients en attente</p>
                            <p class="text-3xl font-bold text-purple-600">
                                <%
                                    List<Patient> patientsAttente = (List<Patient>) request.getAttribute("patientsAttente");
                                    int nbAttente = (patientsAttente != null) ? patientsAttente.size() : 0;
                                %>
                                <%= nbAttente %>
                            </p>
                        </div>
                        <div class="w-14 h-14 gradient-bg rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600 mb-1">Consultations aujourd'hui</p>
                            <p class="text-3xl font-bold text-purple-600">
                                <%
                                    Integer nbConsultations = (Integer) request.getAttribute("nbConsultationsJour");
                                %>
                                <%= (nbConsultations != null) ? nbConsultations : 0 %>
                            </p>
                        </div>
                        <div class="w-14 h-14 gradient-bg rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="stats-card">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600 mb-1">Actes techniques</p>
                            <p class="text-3xl font-bold text-purple-600">
                                <%
                                    Integer nbActes = (Integer) request.getAttribute("nbActesJour");
                                %>
                                <%= (nbActes != null) ? nbActes : 0 %>
                            </p>
                        </div>
                        <div class="w-14 h-14 gradient-bg rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Patients en attente -->
        <section id="patients-attente" class="w-full max-w-7xl mx-auto py-6 fade-in">
            <div class="glass-effect rounded-2xl shadow-2xl p-8 card-hover">
                <div class="flex items-center justify-between mb-8">
                    <div class="flex items-center space-x-3">
                        <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-indigo-600 bg-clip-text text-transparent">Patients en attente</h3>
                            <p class="text-sm text-gray-500 mt-1">Liste des patients à consulter</p>
                        </div>
                    </div>
                    <span class="badge badge-warning"><%= nbAttente %> patient(s)</span>
                </div>

                <div class="overflow-x-auto rounded-xl">
                    <table class="min-w-full">
                        <thead>
                        <tr class="border-b-2 border-gray-200">
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Nom</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Prénom</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">NSS</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Date arrivée</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                        <%
                            if (patientsAttente != null && !patientsAttente.isEmpty()) {
                                for (Patient p : patientsAttente) {
                        %>
                        <tr class="table-row-hover">
                            <td class="px-6 py-4 text-gray-800 font-medium"><%= p.getNom() %></td>
                            <td class="px-6 py-4 text-gray-800"><%= p.getPrenom() %></td>
                            <td class="px-6 py-4 text-gray-600"><%= p.getNumSecuriteSociale() %></td>
                            <td class="px-6 py-4 text-gray-600"><%= p.getDateArrivee() %></td>
                            <td class="px-6 py-4">
                                <button onclick="openConsultationForm('<%= p.getId() %>', '<%= p.getNom() %>', '<%= p.getPrenom() %>')"
                                        class="gradient-bg text-white px-4 py-2 rounded-lg font-medium hover:opacity-90 transition transform hover:scale-105 flex items-center space-x-2">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                    </svg>
                                    <span>Consulter</span>
                                </button>
                            </td>
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
                                <p class="text-gray-400 text-lg font-medium">Aucun patient en attente</p>
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

        <!-- Formulaire Consultation -->
        <section id="consultation-form" class="w-full max-w-7xl mx-auto py-6 hidden fade-in">
            <div class="glass-effect rounded-2xl shadow-2xl p-8 lg:p-12 card-hover">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-indigo-600 bg-clip-text text-transparent">Créer une consultation</h3>
                        <p class="text-sm text-gray-500 mt-1">Patient: <span id="patientInfo" class="font-semibold text-purple-600"></span></p>
                    </div>
                </div>

                <form action="<%=request.getContextPath()%>/generaliste/consultation" method="post" class="space-y-6">
                    <input type="hidden" id="patientId" name="patientId" />

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                        <div class="lg:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Diagnostic</label>
                            <textarea name="diagnostic" rows="4" required
                                      class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none"
                                      placeholder="Saisir le diagnostic médical"></textarea>
                        </div>

                        <div class="lg:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Prescription</label>
                            <textarea name="prescription" rows="4" required
                                      class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none"
                                      placeholder="Détails du traitement et médicaments prescrits"></textarea>
                        </div>

                        <div class="lg:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Symptômes</label>
                            <textarea name="symptomes" rows="3"
                                      class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none"
                                      placeholder="Symptômes déclarés par le patient (optionnel)"></textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Date de consultation</label>
                            <input type="date" name="dateConsultation" required
                                   class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                        </div>


                        <div class="lg:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Observations</label>
                            <textarea name="observations" rows="3"
                                      class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none"
                                      placeholder="Observations complémentaires (optionnel)"></textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Coût (€)</label>
                            <input type="number" step="0.01" name="cout" required
                                   class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none"
                                   placeholder="0.00" />
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Statut</label>
                            <select name="statut" required
                                    class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none">
                                <option value="">-- Sélectionner un statut --</option>
                                <option value="TERMINEE">Terminée</option>
                                <option value="EN_ATTENTE_AVIS_SPECIALISTE">En attente d'avis spécialiste</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex justify-end space-x-4 mt-8">
                        <button type="button" onclick="toggleSection('consultation-form')"
                                class="px-8 py-4 rounded-xl border-2 border-gray-300 text-gray-700 font-bold hover:bg-gray-50 transition">
                            Annuler
                        </button>
                        <button type="submit"
                                class="gradient-bg hover:opacity-90 text-white font-bold py-4 px-10 rounded-xl shadow-lg transition transform hover:scale-105 flex items-center space-x-2">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                            <span>Enregistrer la consultation</span>
                        </button>
                    </div>
                </form>
            </div>
        </section>

        <!-- Formulaire Actes Techniques -->
        <section id="actes-form" class="w-full max-w-7xl mx-auto py-6 hidden fade-in">
            <div class="glass-effect rounded-2xl shadow-2xl p-8 lg:p-12 card-hover">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-indigo-600 bg-clip-text text-transparent">Ajouter des actes techniques</h3>
                        <p class="text-sm text-gray-500 mt-1">Enregistrer les actes réalisés durant la consultation</p>
                    </div>
                </div>

                <form action="<%=request.getContextPath()%>/generaliste/actes" method="post" class="space-y-6">
                    <input type="hidden" id="consultationId" name="consultationId" />

                    <div class="bg-gradient-to-br from-purple-50 to-indigo-50 rounded-xl p-6 mb-6">
                        <h4 class="text-lg font-bold text-gray-800 mb-4 flex items-center">
                            <svg class="w-5 h-5 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            Informations
                        </h4>
                        <p class="text-sm text-gray-600">Sélectionnez une consultation existante et ajoutez les actes techniques réalisés.</p>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                        <div class="lg:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Consultation</label>
                            <select name="consultationIdSelect" required
                                    class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none">
                                <option value="">-- Sélectionner une consultation --</option>
                                <%
                                    List<Consultation> consultations = (List<Consultation>) request.getAttribute("consultations");
                                    if (consultations != null) {
                                        for (Consultation c : consultations) {
                                %>

                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="lg:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Type d'acte technique</label>
                            <select name="typeActe" required
                                    class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none">
                                <option value="">-- Sélectionner un acte --</option>
                                <option value="RADIOGRAPHIE">RADIOGRAPHIE</option>
                                <option value="ECHOGRAPHIE">ECHOGRAPHIE</option>
                                <option value="IRM">IRM</option>
                                <option value="ELECTROCARDIOGRAMME">ELECTROCARDIOGRAMME</option>
                                <option value="DERMATOLOGIE_LASER">DERMATOLOGIE_LASER</option>
                                <option value="FOND_OEIL">FOND_OEIL</option>
                                <option value="ANALYSE_SANG">ANALYSE_SANG</option>
                                <option value="ANALYSE_URINE">ANALYSE_URINE</option>
                            </select>
                        </div>

                        <div class="lg:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Description de l'acte</label>
                            <textarea name="descriptionActe" rows="4" required
                                      class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none"
                                      placeholder="Détails de l'acte technique réalisé"></textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Date de réalisation</label>
                            <input type="date" name="dateActe" required
                                   class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none" />
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Coût (€)</label>
                            <input type="number" step="0.01" name="coutActe" required
                                   class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none"
                                   placeholder="0.00" />
                        </div>

                        <div class="lg:col-span-2">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Résultats / Observations</label>
                            <textarea name="resultatsActe" rows="3"
                                      class="input-modern w-full border-2 border-gray-200 rounded-xl px-5 py-3.5 focus:border-purple-500 focus:outline-none"
                                      placeholder="Résultats obtenus ou observations (optionnel)"></textarea>
                        </div>
                    </div>

                    <div class="flex justify-end space-x-4 mt-8">
                        <button type="button" onclick="toggleSection('actes-form')"
                                class="px-8 py-4 rounded-xl border-2 border-gray-300 text-gray-700 font-bold hover:bg-gray-50 transition">
                            Annuler
                        </button>
                        <button type="submit"
                                class="gradient-bg hover:opacity-90 text-white font-bold py-4 px-10 rounded-xl shadow-lg transition transform hover:scale-105 flex items-center space-x-2">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                            <span>Enregistrer l'acte</span>
                        </button>
                    </div>
                </form>
            </div>
        </section>

        <!-- Liste des consultations récentes -->
        <section class="w-full max-w-7xl mx-auto py-6 fade-in">
            <div class="glass-effect rounded-2xl shadow-2xl p-8 card-hover">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-indigo-600 bg-clip-text text-transparent">Consultations récentes</h3>
                        <p class="text-sm text-gray-500 mt-1">Historique des consultations d'aujourd'hui</p>
                    </div>
                </div>

                <div class="overflow-x-auto rounded-xl">
                    <table class="min-w-full">
                        <thead>
                        <tr class="border-b-2 border-gray-200">
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Patient</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Date</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Diagnostic</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Décision</th>
                            <th class="px-6 py-4 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                        <%
                            List<Consultation> consultationsRecentes = (List<Consultation>) request.getAttribute("consultationsRecentes");
                            if (consultationsRecentes != null && !consultationsRecentes.isEmpty()) {
                                for (Consultation cons : consultationsRecentes) {
                        %>
                        <tr class="table-row-hover">
                            <td class="px-6 py-4 text-gray-800 font-medium">
                            </td>
                            <td class="px-6 py-4 text-gray-600"><%= cons.getDateConsultation() %></td>
                            <td class="px-6 py-4 text-gray-600">
                                <div class="max-w-xs truncate" title="<%= cons.getDiagnostic() %>">
                                    <%= cons.getDiagnostic() %>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                            </td>
                            <td class="px-6 py-4">
                                <button onclick="openActesForm('<%= cons.getId() %>')"
                                        class="text-purple-600 hover:text-purple-800 font-medium flex items-center space-x-1 transition">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                    </svg>
                                    <span>Ajouter acte</span>
                                </button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center py-12">
                                <svg class="w-16 h-16 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                                <p class="text-gray-400 text-lg font-medium">Aucune consultation enregistrée aujourd'hui</p>
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