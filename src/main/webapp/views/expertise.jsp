<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.medexpert.model.Specialiste" %>
<%@ page import="org.example.medexpert.model.Consultation" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demande d'expertise</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="max-w-2xl mx-auto my-10 bg-white shadow rounded-xl p-8 border border-slate-200">
    <h1 class="text-2xl font-bold mb-6 text-slate-900">Créer une demande d'expertise</h1>

    <%
        Consultation consultation = (Consultation) request.getAttribute("consultation");
        List<Specialiste> specialistes = (List<Specialiste>) request.getAttribute("specialistes");
    %>

    <form action="<%=request.getContextPath()%>/generaliste/expertise" method="post" class="space-y-5">
        <input type="hidden" name="consultationId" value="<%= consultation != null ? consultation.getId() : "" %>"/>

        <div>
            <label class="block text-sm font-semibold mb-2">Spécialiste</label>
            <select name="specialisteId" required class="w-full border rounded px-3 py-2">
                <option value="">-- Sélectionner un spécialiste --</option>
                <%
                    if (specialistes != null) {
                        for (Specialiste s : specialistes) {
                %>
                <option value="<%= s.getId() %>"><%= s.getPrenom() %> <%= s.getNom() %></option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div>
            <label class="block text-sm font-semibold mb-2">Priorité</label>
            <select name="priorite" required class="w-full border rounded px-3 py-2">
                <option value="NORMALE">Normale</option>
                <option value="URGENTE">Urgente</option>
                <option value="HAUTE">Haute</option>
            </select>
        </div>

        <div>
            <label class="block text-sm font-semibold mb-2">Question</label>
            <textarea name="question" rows="4" required class="w-full border rounded px-3 py-2" placeholder="Décrivez la question médicale pour le spécialiste..."></textarea>
        </div>

        <div class="flex justify-end gap-3">
            <a href="<%=request.getContextPath()%>/generaliste" class="px-5 py-2 border rounded border-slate-300 text-slate-700 hover:bg-gray-50">Annuler</a>
            <button type="submit" class="px-5 py-2 bg-sky-600 hover:bg-sky-700 text-white rounded">Envoyer</button>
        </div>
    </form>
</div>
</body>
</html>


