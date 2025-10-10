<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', Arial, sans-serif; }
        .fade-in {
            animation: fadeIn 1.2s cubic-bezier(.4,0,.2,1) both;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .slide-in {
            animation: slideIn 1.2s cubic-bezier(.4,0,.2,1) both;
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-40px); }
            to { opacity: 1; transform: translateX(0); }
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-fuchsia-100 via-rose-100 to-orange-100">
<div class="w-full max-w-6xl bg-white/90 rounded-3xl shadow-2xl p-0 flex flex-col md:flex-row overflow-hidden fade-in">
    <!-- Illustration & Slogan -->
    <div class="md:w-1/2 flex flex-col items-center justify-center bg-gradient-to-br from-rose-400 to-orange-300 p-10 text-white slide-in">
        <svg class="w-32 mb-6 animate-bounce" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
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
        <h2 class="text-3xl font-extrabold mb-2 tracking-wide drop-shadow">Bienvenue sur MedExpert</h2>
        <p class="text-lg font-medium mb-4">La plateforme intelligente pour les professionnels de santé</p>
        <div class="flex flex-col gap-2 mt-4">
            <span class="inline-block px-4 py-1 rounded-full bg-white/20 text-white font-semibold text-sm animate-pulse">Inscription Médecin, Infirmier, Patient</span>
            <span class="inline-block px-4 py-1 rounded-full bg-white/20 text-white font-semibold text-sm animate-pulse">Sécurité & Confidentialité</span>
        </div>
    </div>
    <!-- Formulaire -->
    <div class="md:w-1/2 w-full flex flex-col items-center justify-center p-10 fade-in">
        <h2 class="text-2xl font-bold text-rose-600 mb-6 tracking-wide">Créer un compte</h2>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="w-full mb-4 px-4 py-3 rounded bg-red-100 border border-red-400 text-red-700 text-center text-base animate-pulse"><%= error %></div>
        <% } %>
        <form action="<%=request.getContextPath()%>/register" method="post" autocomplete="off" class="w-full flex flex-col gap-4">
            <div class="flex flex-col md:flex-row gap-4">
                <div class="flex-1 flex flex-col gap-1">
                    <label for="nom" class="text-gray-700 font-medium">Nom</label>
                    <input type="text" id="nom" name="nom" placeholder="Votre nom" required
                           class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
                </div>
                <div class="flex-1 flex flex-col gap-1">
                    <label for="prenom" class="text-gray-700 font-medium">Prénom</label>
                    <input type="text" id="prenom" name="prenom" placeholder="Votre prénom" required
                           class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
                </div>
            </div>
            <div class="flex flex-col md:flex-row gap-4">
                <div class="flex-1 flex flex-col gap-1">
                    <label for="email" class="text-gray-700 font-medium">Adresse e-mail</label>
                    <input type="email" id="email" name="email" placeholder="Votre e-mail" required
                           class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
                </div>
                <div class="flex-1 flex flex-col gap-1">
                    <label for="role" class="text-gray-700 font-medium">Rôle</label>
                    <select id="role" name="role" required
                            class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition"
                            onchange="handleRoleChange()">
                        <option value="">Sélectionnez un rôle</option>
                        <option value="PATIENT">Patient</option>
                        <option value="INFIRMIER">Infirmier</option>
                        <option value="MEDECIN_GENERALISTE">Généraliste</option>
                        <option value="MEDECIN_SPECIALISTE">Spécialiste</option>
                    </select>
                </div>
            </div>
            <div class="flex flex-col md:flex-row gap-4">
                <div class="flex-1 flex flex-col gap-1">
                    <label for="password" class="text-gray-700 font-medium">Mot de passe</label>
                    <input type="password" id="password" name="password" placeholder="Mot de passe" required
                           class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
                </div>
                <div class="flex-1 flex flex-col gap-1">
                    <label for="confirmPassword" class="text-gray-700 font-medium">Confirmer le mot de passe</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirmez le mot de passe" required
                           class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
                </div>
            </div>
            <div id="specialiteField" class="flex flex-col gap-1 hidden">
                <label for="specialite" class="text-gray-700 font-medium">Spécialité</label>
                <input type="text" id="specialite" name="specialite" placeholder="Votre spécialité médicale"
                       class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
            </div>
            <div id="serviceField" class="flex flex-col gap-1 hidden">
                <label for="service" class="text-gray-700 font-medium">Service</label>
                <input type="text" id="service" name="service" placeholder="Votre service (ex: Urgences, Pédiatrie)"
                       class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-rose-400 bg-gray-50 transition" />
            </div>
            <button type="submit" class="w-full py-3 mt-2 rounded-xl bg-gradient-to-r from-rose-500 to-orange-400 text-white font-bold text-lg shadow-lg hover:from-rose-600 hover:to-orange-500 transition-all duration-300 transform hover:scale-105">Créer le compte</button>
        </form>
        <div class="mt-6 text-gray-500 text-sm text-center">
            Déjà inscrit ? <a href="<%=request.getContextPath()%>/views/login.jsp" class="text-rose-600 hover:underline font-semibold">Se connecter</a>
        </div>
        <div class="mt-2 text-gray-400 text-xs text-center">
            © <%= java.time.Year.now() %> MedExpert. Tous droits réservés.
        </div>
    </div>
</div>
<script>
    function handleRoleChange() {
        const role = document.getElementById('role').value;
        document.getElementById('specialiteField').classList.add('hidden');
        document.getElementById('serviceField').classList.add('hidden');
        if (role === 'MEDECIN_SPECIALISTE') {
            document.getElementById('specialiteField').classList.remove('hidden');
        } else if (role === 'INFIRMIER') {
            document.getElementById('serviceField').classList.remove('hidden');
        }
    }
    window.onload = handleRoleChange;
</script>
</body>
</html>
