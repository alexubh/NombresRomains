import unittest

from ConvertisseurNombresRomains import ConvertisseurNombresRomains


class NombresRomainsTest(unittest.TestCase):
    def test_un(self):
        # ETANT DONNE le chiffre 1
        nombre_arabe = 1

        # QUAND on le convertit en nombres romains
        nombre_romain = ConvertisseurNombresRomains.convertir(nombre_arabe)

        # ALORS on obtient "I"
        self.assertEqual("I", nombre_romain)

    def test_deux(self):
        # ETANT DONNE le chiffre 2
        nombre_arabe = 2

        # QUAND on le convertit en nombres romains
        nombre_romain = ConvertisseurNombresRomains.convertir(nombre_arabe)

        # ALORS on obtient "II"
        self.assertEqual("II", nombre_romain)
