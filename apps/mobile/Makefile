.PHONY: build_runner watch get clean

# Flutter version management
FLUTTER := fvm flutter
DART := fvm dart

# コード生成
build_runner:
	@echo "🔨 Building mobile app..."
	$(DART) run build_runner build --delete-conflicting-outputs

# ファイル変更を監視
watch:
	@echo "👀 Watching mobile app..."
	$(DART) run build_runner watch --delete-conflicting-outputs

# 依存関係の取得
get:
	@echo "📦 Getting dependencies for mobile app..."
	$(FLUTTER) pub get

# ビルドキャッシュのクリーン
clean:
	@echo "🧹 Cleaning mobile app build cache..."
	$(DART) run build_runner clean
