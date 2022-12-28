import csv


class MembersRepository:
    def __init__(self, members_file):
        with open(members_file, encoding='utf8') as f:
            reader = csv.reader(f)
            # skip header
            _ = next(reader)
            self.members = {}
            for row in reader:
                self.members[row[2] + row[3]] = {'mail_address': row[0], 'kana': row[4] + row[5]}
        print(self.members)

    def get_members(self):
        return self.members
