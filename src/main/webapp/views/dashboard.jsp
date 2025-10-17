<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.medexpert.model.Utilisateur" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Roboto', Arial, sans-serif; }</style>
</head>
<body class="min-h-screen bg-gray-50 flex flex-col">
<%
    HttpSession sessiontest = request.getSession(false);
    Utilisateur user = (Utilisateur) (sessiontest != null ? sessiontest.getAttribute("user") : null);
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }
%>
<nav class="w-full bg-white border-b border-slate-200 flex items-center justify-between px-8 py-4">
    <div class="text-xl font-bold text-slate-900 tracking-tight">MedExpert</div>
    <div class="flex items-center gap-4">
        <span class="text-gray-700 font-medium">Bienvenue, <%= user.getPrenom() %> <%= user.getNom() %></span>
        <span class="px-3 py-1 rounded bg-slate-100 text-slate-700 text-xs font-semibold"><%= user.getRole() %></span>
        <form action="<%=request.getContextPath()%>/logout" method="post" class="inline">
            <button type="submit" class="ml-4 px-4 py-2 rounded bg-sky-600 hover:bg-sky-700 text-white font-semibold transition">Déconnexion</button>
        </form>
    </div>
</nav>
<main class="flex-1 flex flex-col items-center justify-center p-8">
    <div class="bg-white rounded-2xl shadow p-8 w-full max-w-2xl flex flex-col items-center border border-slate-200">
        <h1 class="text-3xl font-bold text-slate-900 mb-4">Tableau de bord</h1>
        <p class="text-gray-700 text-lg mb-6">Bienvenue sur votre espace personnel, <span class="font-semibold"><%= user.getPrenom() %> <%= user.getNom() %></span> !</p>
        <div class="w-full grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="bg-gray-50 rounded-xl p-6 flex flex-col items-center border border-slate-200">
                <span class="text-5xl text-slate-400 mb-2">👤</span>
                <span class="text-gray-700 font-semibold">Nom :</span>
                <span class="text-slate-900 mb-2"><%= user.getNom() %></span>
                <span class="text-gray-700 font-semibold">Prénom :</span>
                <span class="text-slate-900 mb-2"><%= user.getPrenom() %></span>
                <span class="text-gray-700 font-semibold">Email :</span>
                <span class="text-slate-900 mb-2"><%= user.getEmail() %></span>
                <span class="text-gray-700 font-semibold">Rôle :</span>
                <span class="text-slate-900 mb-2"><%= user.getRole() %></span>
            </div>
            <div class="bg-gray-50 rounded-xl p-6 flex flex-col items-center border border-slate-200">
                <span class="text-5xl text-slate-400 mb-2">⚙️</span>
                <span class="text-gray-700 font-semibold mb-2">Actions rapides</span>
                <a href="#" class="w-full text-center py-2 my-1 rounded bg-sky-600 hover:bg-sky-700 text-white font-semibold transition">Voir mon profil</a>
                <a href="#" class="w-full text-center py-2 my-1 rounded bg-sky-600 hover:bg-sky-700 text-white font-semibold transition">Modifier mes informations</a>
                <a href="#" class="w-full text-center py-2 my-1 rounded bg-sky-600 hover:bg-sky-700 text-white font-semibold transition">Consulter mes dossiers</a>
            </div>
        </div>
    </div>
</main>
<footer class="w-full text-center py-4 text-gray-400 text-sm mt-8">
    © <%= java.time.Year.now() %> MedExpert. Tous droits réservés.
</footer>
</body>
</html>
