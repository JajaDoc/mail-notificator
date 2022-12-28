from PySide2 import QtCore

from repository.member import MembersRepository

aiueo = [
    ['ア', 'イ', 'ウ', 'エ', 'オ'],
    ['カ', 'キ', 'ク', 'ケ', 'コ'],
    ['サ', 'シ', 'ス', 'セ', 'ソ'],
    ['タ', 'チ', 'ツ', 'テ', 'ト'],
    ['ナ', 'ニ', 'ヌ', 'ネ', 'ノ'],
    ['ハ', 'ヒ', 'フ', 'ヘ', 'ホ'],
    ['マ', 'ミ', 'ム', 'メ', 'モ'],
    ['ヤ', 'ユ', 'ヨ'],
    ['ラ', 'リ', 'ル', 'レ', 'ロ'],
    ['ワ', 'ヲ', 'ン'],
]


class MembersViewModel(QtCore.QObject):

    def __init__(self, member_repository: MembersRepository):
        super(MembersViewModel, self).__init__()
        self.member_repository = member_repository

    @QtCore.Slot(result='QVariant')
    def get_sorted_members(self):
        members = self.member_repository.get_members()
        members = sorted(
            [
                [k, members[k]['kana'], members[k]['mail_address']]
                for k in members.keys()
            ],
            key=lambda x: x[1]
        )

        bookmarks = []
        for i in range(len(aiueo)):
            for j in range(len(aiueo[i])):
                found = False
                for n, member in enumerate(members):
                    if member[1].startswith(aiueo[i][j]):
                        found = True
                        bookmarks.append(n)
                        break

                if found:
                    break

        return [members, bookmarks]
