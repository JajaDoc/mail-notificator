import json
import os

from PySide2 import QtCore

from extract import extract
from repository.member import MembersRepository
from repository.gcp_vision import GCPVisionRepository


class CameraViewModel(QtCore.QObject):
    onCompletedOCR = QtCore.Signal('QVariantMap')

    def __init__(self, members_repository: MembersRepository, vision_repository: GCPVisionRepository):
        super(CameraViewModel, self).__init__()
        self.members_repository = members_repository
        self.vision_repository = vision_repository

    @QtCore.Slot(str, result='QVariant')
    def start_ocr(self, filename):
        print('start ocr')

        image_filename = os.path.abspath(filename)
        output_text = self.vision_repository.do_ocr(image_filename)
        print(output_text)

        members = self.members_repository.get_members()
        to_name, froms = extract(output_text, members.keys())
        print(members)

        to_address = None
        if to_name in members:
            to_address = members[to_name]['mail_address']
        dirname = os.path.dirname(image_filename)
        basename = os.path.splitext(os.path.basename(image_filename))[0]
        with open(f'{dirname}/{basename}.txt', mode='w') as f:
            f.write(json.dumps({'to_name': to_name, 'to_address': to_address, 'output_text': output_text}))

        return to_name, to_address, froms, image_filename
