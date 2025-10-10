<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.medexpert.model.Utilisateur" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>MedExpert - Accueil</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-100 to-indigo-200 min-h-screen flex items-center justify-center">
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
%>
<div class="bg-white/90 rounded-2xl shadow-2xl p-10 w-full max-w-md text-center">
    <h1 class="text-3xl font-bold text-indigo-700 mb-2">Bienvenue sur <span class="text-blue-500">MedExpert</span></h1>
    <p class="text-gray-500 mb-8">Votre plateforme médicale intelligente</p>
    <% if (utilisateur != null) { %>
        <div class="mb-6">
            <span class="block text-lg text-indigo-600 font-semibold mb-2">Bonjour, <%= utilisateur.getNom() %> <%= utilisateur.getPrenom() %> !</span>
        </div>
        <form action="logout" method="post" class="inline">
            <button type="submit" class="px-6 py-2 rounded-lg bg-gradient-to-r from-indigo-500 to-blue-400 text-white font-semibold shadow hover:from-blue-400 hover:to-indigo-500 transition">Se déconnecter</button>
        </form>
    <% } else { %>
        <div class="flex flex-col gap-4 mb-6">
            <a href="views/login.jsp" class="px-6 py-2 rounded-lg bg-gradient-to-r from-indigo-500 to-blue-400 text-white font-semibold shadow hover:from-blue-400 hover:to-indigo-500 transition">Se connecter</a>
            <a href="views/register.jsp" class="px-6 py-2 rounded-lg bg-gradient-to-r from-blue-400 to-indigo-500 text-white font-semibold shadow hover:from-indigo-500 hover:to-blue-400 transition">S'inscrire</a>
        </div>
    <% } %>
</div>
</body>
</html>
