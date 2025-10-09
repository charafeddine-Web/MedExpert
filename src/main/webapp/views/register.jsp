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
    </style>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-700 via-sky-300 to-white">
<div class="w-full max-w-lg bg-white rounded-2xl shadow-2xl p-8 flex flex-col items-center">
    <h2 class="text-2xl font-bold text-blue-700 mb-6 tracking-wide">Créer un compte MedExpert</h2>
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="w-full mb-4 px-4 py-3 rounded bg-red-100 border border-red-400 text-red-700 text-center text-base"><%= error %></div>
    <% } %>
    <form action="<%=request.getContextPath()%>/register" method="post" autocomplete="off" class="w-full flex flex-col gap-4">
        <div class="flex flex-col gap-1">
            <label for="nom" class="text-gray-700 font-medium">Nom</label>
            <input type="text" id="nom" name="nom" placeholder="Votre nom" required
                   class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-400 bg-gray-50" />
        </div>
        <div class="flex flex-col gap-1">
            <label for="prenom" class="text-gray-700 font-medium">Prénom</label>
            <input type="text" id="prenom" name="prenom" placeholder="Votre prénom" required
                   class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-400 bg-gray-50" />
        </div>
        <div class="flex flex-col gap-1">
            <label for="email" class="text-gray-700 font-medium">Adresse e-mail</label>
            <input type="email" id="email" name="email" placeholder="Votre e-mail" required
                   class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-400 bg-gray-50" />
        </div>
        <div class="flex flex-col gap-1">
            <label for="password" class="text-gray-700 font-medium">Mot de passe</label>
            <input type="password" id="password" name="password" placeholder="Mot de passe" required
                   class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-400 bg-gray-50" />
        </div>
        <div class="flex flex-col gap-1">
            <label for="confirmPassword" class="text-gray-700 font-medium">Confirmer le mot de passe</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirmez le mot de passe" required
                   class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-400 bg-gray-50" />
        </div>
        <div class="flex flex-col gap-1">
            <label for="role" class="text-gray-700 font-medium">Rôle</label>
            <select id="role" name="role" required
                    class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-400 bg-gray-50">
                <option value="">Sélectionnez un rôle</option>
                <option value="PATIENT">Patient</option>
                <option value="INFIRMIER">Infirmier</option>
                <option value="GENERALISTE">Généraliste</option>
                <option value="SPECIALISTE">Spécialiste</option>
            </select>
        </div>
        <button type="submit" class="w-full py-2 mt-2 rounded bg-gradient-to-r from-blue-700 to-sky-400 text-white font-bold text-lg shadow hover:from-blue-800 hover:to-sky-500 transition">Créer le compte</button>
    </form>
    <div class="mt-6 text-gray-500 text-sm text-center">
        Déjà inscrit ? <a href="<%=request.getContextPath()%>/views/login.jsp" class="text-blue-700 hover:underline font-semibold">Se connecter</a>
    </div>
    <div class="mt-2 text-gray-400 text-xs text-center">
        © <%= java.time.Year.now() %> MedExpert. Tous droits réservés.
    </div>
</div>
</body>
</html>
