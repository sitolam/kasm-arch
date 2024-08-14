import sys
import aqt.qt

constants = __import__('constants', globals(), locals(), [], sys._addon_import_level_base)
component_common = __import__('component_common', globals(), locals(), [], sys._addon_import_level_base)
batch_status = __import__('batch_status', globals(), locals(), [], sys._addon_import_level_base)
errors = __import__('errors', globals(), locals(), [], sys._addon_import_level_base)
logging_utils = __import__('logging_utils', globals(), locals(), [], sys._addon_import_level_base)
logger = logging_utils.get_child_logger(__name__)

class LabelPreview(component_common.ComponentBase):
    def __init__(self, hypertts, note):
        self.hypertts = hypertts
        self.note = note
        self.batch_label = aqt.qt.QLabel()
        self.source_preview_label = aqt.qt.QLabel()
        self.source_preview_label.setWordWrap(True)

    def load_model(self, model):
        try:
            self.batch_model = model
            self.batch_label.setText(str(self.batch_model))
            if self.batch_model.text_processing != None:
                source_text, processed_text = self.hypertts.get_source_processed_text(self.note, self.batch_model.source, self.batch_model.text_processing)
                self.source_preview_label.setText(f'<b>Generating Audio for:</b> {processed_text}')
        except errors.HyperTTSError as error:
            message = f'<b>Encountered Error:</b> {str(error)}'
            self.source_preview_label.setText(message)

    def draw(self):
        # populate processed text

        self.batch_label_layout = aqt.qt.QVBoxLayout()

        self.batch_label_layout.addWidget(self.batch_label)
        self.batch_label_layout.addWidget(self.source_preview_label)
        return self.batch_label_layout
