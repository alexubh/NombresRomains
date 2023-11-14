import os
import sys

# Obtient le chemin du répertoire parent
current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Ajoute le répertoire parent au chemin d'accès Python
sys.path.append(parent_dir)