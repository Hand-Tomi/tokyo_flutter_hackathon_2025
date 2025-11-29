.PHONY: help setup bootstrap clean get build-runner watch test run format lint
.PHONY: build-domain build-design-system build-presentation build-mobile
.PHONY: watch-presentation watch-mobile

# Flutter version management
FLUTTER := fvm flutter
DART := fvm dart
MELOS := $(DART) pub global run melos

# デフォルトターゲット - ヘルプを表示
help:
	@echo "利用可能なコマンド:"
	@echo ""
	@echo "[全体操作]"
	@echo "  make setup        - FVMとFlutter環境の初期セットアップ"
	@echo "  make bootstrap    - Melosワークスペースの初期化と依存関係のインストール"
	@echo "  make get          - 全パッケージの依存関係を取得"
	@echo "  make clean        - ビルドキャッシュとnode_modulesをクリーン"
	@echo "  make build-runner - コード生成を実行 (freezed, riverpod_generator等)"
	@echo "  make watch        - ファイル変更を監視してコード生成"
	@echo "  make test         - 全パッケージのテストを実行"
	@echo "  make format       - コードフォーマットを実行"
	@echo "  make lint         - Lintチェックを実行"
	@echo ""
	@echo "[個別パッケージ - ビルド]"
	@echo "  make build-domain       - domainパッケージのみビルド"
	@echo "  make build-design-system - design_systemパッケージのみビルド"
	@echo "  make build-presentation - presentationパッケージのみビルド"
	@echo "  make build-mobile       - mobileアプリのみビルド"
	@echo ""
	@echo "[個別パッケージ - Watch]"
	@echo "  make watch-presentation - presentationパッケージをwatch"
	@echo "  make watch-mobile       - mobileアプリをwatch"
	@echo ""
	@echo "[アプリ実行]"
	@echo "  make run          - アプリを実行"
	@echo "  make run-dev      - 開発モードでアプリを実行"
	@echo "  make run-prod     - プロダクションモードでアプリを実行"

# Melosワークスペースの初期化
bootstrap:
	@echo "🚀 Bootstrapping workspace..."
	$(MELOS) bootstrap

# 依存関係の取得
get:
	@echo "📦 Getting dependencies..."
	$(MELOS) exec -- $(FLUTTER) pub get

# クリーン
clean:
	@echo "🧹 Cleaning..."
	$(FLUTTER) clean
	$(MELOS) exec -- $(FLUTTER) clean
	find . -name "*.g.dart" -type f -delete
	find . -name "*.freezed.dart" -type f -delete

# コード生成
build-runner:
	@echo "🔨 Running build_runner..."
	$(MELOS) exec --order-dependents --depends-on="build_runner" -- $(DART) run build_runner build --delete-conflicting-outputs

# ファイル変更を監視してコード生成
watch:
	@echo "👀 Watching for changes..."
	$(MELOS) exec --order-dependents --depends-on="build_runner" -- $(DART) run build_runner watch --delete-conflicting-outputs

# テスト実行
test:
	@echo "🧪 Running tests..."
	$(MELOS) exec -- $(FLUTTER) test

# コードフォーマット
format:
	@echo "✨ Formatting code..."
	$(DART) format .

# Lint実行
lint:
	@echo "🔍 Running lint..."
	$(MELOS) exec -- $(FLUTTER) analyze

# アプリ実行
run:
	@echo "🏃 Running app..."
	$(FLUTTER) run

# 開発モードで実行
run-dev:
	@echo "🏃 Running app in development mode..."
	$(FLUTTER) run --debug

# プロダクションモードで実行
run-prod:
	@echo "🏃 Running app in production mode..."
	$(FLUTTER) run --release

# FVMとFlutter環境の初期セットアップ
setup:
	@echo "🔧 Setting up FVM and Flutter environment..."
	@command -v fvm >/dev/null 2>&1 || { echo "❌ FVM is not installed. Please install FVM first: https://fvm.app/documentation/getting-started/installation"; exit 1; }
	@echo "📥 Installing Flutter version from .fvmrc..."
	fvm install
	@echo "✅ FVM setup complete!"
	@echo "📦 Installing Melos..."
	$(DART) pub global activate melos
	@echo "✅ Melos installed!"
	@echo "🚀 Bootstrapping workspace..."
	@$(MAKE) bootstrap
	@echo "🧹 Cleaning build cache..."
	@$(MELOS) exec --depends-on="build_runner" -- $(DART) run build_runner clean
	@echo "🔨 Running build_runner..."
	@$(MAKE) build-runner
	@echo "✅ Setup complete!"

# フルリビルド
rebuild: clean bootstrap build-runner
	@echo "✅ Rebuild complete!"

# ====================================
# 個別パッケージ操作
# ====================================

# domainパッケージ
build-domain:
	@echo "📦 Building domain package..."
	@make -C packages/domain build

# design_systemパッケージ
build-design-system:
	@echo "📦 Building design_system package..."
	@make -C packages/design_system build

# presentationパッケージ
build-presentation:
	@echo "📦 Building presentation package..."
	@make -C packages/presentation build

watch-presentation:
	@echo "👀 Watching presentation package..."
	@make -C packages/presentation watch

# mobileアプリ
build-mobile:
	@echo "📱 Building mobile app..."
	@make -C apps/mobile build

watch-mobile:
	@echo "👀 Watching mobile app..."
	@make -C apps/mobile watch
