<%--
  Created by IntelliJ IDEA.
  User: safiy
  Date: 10/10/2025
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Infirmier - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', Arial, sans-serif; }
        .fade-in { animation: fadeIn 1.2s cubic-bezier(.4,0,.2,1) both; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-fuchsia-100 via-rose-100 to-orange-100">
<div class="w-full max-w-5xl bg-white/90 rounded-3xl shadow-2xl p-0 flex flex-col md:flex-row overflow-hidden fade-in">
    <!-- Menu latéral -->
    <div class="md:w-1/4 bg-gradient-to-br from-rose-400 to-orange-300 p-8 flex flex-col items-center justify-between text-white">
        <div class="flex flex-col items-center gap-4">
            <svg class="w-16 mb-2 animate-bounce" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
                <ellipse cx="100" cy="170" rx="70" ry="15" fill="#fce7f3"/>
                <circle cx="100" cy="90" r="60" fill="#fff" fill-opacity=".15"/>
                <ellipse cx="100" cy="110" rx="40" ry="15" fill="#fff" fill-opacity=".3"/>
                <ellipse cx="80" cy="80" rx="8" ry="12" fill="#fff"/>
                <ellipse cx="120" cy="80" rx="8" ry="12" fill="#fff"/>
                <ellipse cx="100" cy="120" rx="18" ry="8" fill="#f43f5e"/>
                <circle cx="85" cy="85" r="3" fill="#f43f5e"/>
                <circle cx="115" cy="85" r="3" fill="#f43f5e"/>
                <path d="M90 110 Q100 120 110 110" stroke="#f43f5e" stroke-width="3" fill="none"/>
            </svg>
            <h2 class="text-2xl font-bold mb-2 tracking-wide drop-shadow">Module Infirmier</h2>
            <ul class="flex flex-col gap-2 w-full mt-4">
                <li><a href="#enregistrer" class="block px-4 py-2 rounded-lg bg-white/20 hover:bg-white/30 font-semibold transition">Enregistrer un patient</a></li>
                <li><a href="#liste" class="block px-4 py-2 rounded-lg bg-white/20 hover:bg-white/30 font-semibold transition">Patients du jour</a></li>
                <li><a href="#statuts" class="block px-4 py-2 rounded-lg bg-white/20 hover:bg-white/30 font-semibold transition">Statuts en temps réel</a></li>
            </ul>
        </div>
        <div class="mt-8 text-xs text-white/80">© <%= java.time.Year.now() %> MedExpert</div>
    </div>
    <!-- Contenu principal -->
    <div class="md:w-3/4 w-full flex flex-col gap-10 p-10">
        <!-- Enregistrer un patient -->
        <section id="enregistrer" class="mb-8">
            <h3 class="text-xl font-bold text-rose-600 mb-4">Enregistrer un patient</h3>
            <form class="bg-white rounded-xl shadow p-6 flex flex-col md:flex-row gap-6 items-center">
                <div class="flex-1 flex flex-col gap-2">
                    <input type="text" name="nom" placeholder="Nom du patient" required class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
                    <input type="text" name="prenom" placeholder="Prénom du patient" required class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
                    <input type="date" name="dateNaissance" placeholder="Date de naissance" required class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
                </div>
                <div class="flex-1 flex flex-col gap-2">
                    <input type="number" step="0.1" name="temperature" placeholder="Température (°C)" class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-300 bg-gray-50 transition" />
                    <input type="number" step="1" name="frequenceCardiaque" placeholder="Fréquence cardiaque (bpm)" class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-300 bg-gray-50 transition" />
                    <input type="number" step="1" name="tension" placeholder="Tension (mmHg)" class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-300 bg-gray-50 transition" />
                    <input type="number" step="1" name="frequenceRespiratoire" placeholder="Fréquence respiratoire (/min)" class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-300 bg-gray-50 transition" />
                </div>
                <button type="submit" class="h-12 px-8 rounded-xl bg-gradient-to-r from-rose-500 to-orange-400 text-white font-bold text-lg shadow-lg hover:from-rose-600 hover:to-orange-500 transition-all duration-300 transform hover:scale-105 mt-4 md:mt-0">Enregistrer</button>
            </form>
        </section>
        <!-- Liste des patients du jour -->
        <section id="liste" class="mb-8">
            <h3 class="text-xl font-bold text-rose-600 mb-4">Patients du jour</h3>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white rounded-xl shadow">
                    <thead>
                        <tr class="bg-gradient-to-r from-rose-200 to-orange-100 text-rose-700">
                            <th class="px-4 py-2">Nom</th>
                            <th class="px-4 py-2">Prénom</th>
                            <th class="px-4 py-2">Date de naissance</th>
                            <th class="px-4 py-2">Température</th>
                            <th class="px-4 py-2">FC</th>
                            <th class="px-4 py-2">Tension</th>
                            <th class="px-4 py-2">FR</th>
                            <th class="px-4 py-2">Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Exemple de ligne -->
                        <tr class="hover:bg-rose-50 transition">
                            <td class="px-4 py-2 font-semibold">Dupont</td>
                            <td class="px-4 py-2">Marie</td>
                            <td class="px-4 py-2">1990-05-12</td>
                            <td class="px-4 py-2">37.2°C</td>
                            <td class="px-4 py-2">78</td>
                            <td class="px-4 py-2">120/80</td>
                            <td class="px-4 py-2">16</td>
                            <td class="px-4 py-2"><span class="inline-block px-3 py-1 rounded-full bg-green-100 text-green-700 text-xs font-bold animate-pulse">Stable</span></td>
                        </tr>
                        <!-- À remplacer par une boucle sur les patients du jour -->
                    </tbody>
                </table>
            </div>
        </section>
        <!-- Statuts en temps réel -->
        <section id="statuts">
            <h3 class="text-xl font-bold text-rose-600 mb-4">Statuts des patients en temps réel</h3>
            <div class="flex flex-wrap gap-4">
                <!-- Exemple de carte statut -->
                <div class="flex flex-col items-center bg-white rounded-xl shadow p-6 w-60 animate-pulse border-t-4 border-green-400">
                    <span class="text-lg font-bold text-gray-700 mb-2">Marie Dupont</span>
                    <span class="text-sm text-gray-500 mb-2">37.2°C, 78 bpm</span>
                    <span class="inline-block px-3 py-1 rounded-full bg-green-100 text-green-700 text-xs font-bold">Stable</span>
                </div>
                <div class="flex flex-col items-center bg-white rounded-xl shadow p-6 w-60 animate-pulse border-t-4 border-orange-400">
                    <span class="text-lg font-bold text-gray-700 mb-2">Ali Ben</span>
                    <span class="text-sm text-gray-500 mb-2">38.5°C, 110 bpm</span>
                    <span class="inline-block px-3 py-1 rounded-full bg-orange-100 text-orange-700 text-xs font-bold">Surveillance</span>
                </div>
                <!-- À remplacer par une boucle sur les statuts réels -->
            </div>
        </section>
    </div>
</div>
</body>
</html>
