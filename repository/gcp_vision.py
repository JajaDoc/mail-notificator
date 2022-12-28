import io

from google.cloud import vision


class GCPVisionRepository:

    def __init__(self):
        self.client = vision.ImageAnnotatorClient()

    def do_ocr(self, image_filename):
        client = vision.ImageAnnotatorClient()
        with io.open(image_filename, 'rb') as image_file:
            content = image_file.read()
            image = vision.Image(content=content)
            response = client.document_text_detection(
                image=image,
                image_context={'language_hints': ['ja']}
            )
            output_text = ''
            for page in response.full_text_annotation.pages:
                for block in page.blocks:
                    for paragraph in block.paragraphs:
                        for word in paragraph.words:
                            output_text += ''.join([
                                symbol.text for symbol in word.symbols
                            ])

        return output_text
