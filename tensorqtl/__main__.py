import os
os.environ.setdefault('PYTORCH_ENABLE_MPS_FALLBACK', '1')

import tensorqtl
tensorqtl.main()
