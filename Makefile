.PHONY: dev up down

dev:
	npm run dev

up:
	npm install
	npm run build
	npm start

down:
	@PID=$$(lsof -ti:3000) && [ -n "$$PID" ] && kill $$PID && echo "Stopped process on port 3000" || echo "Nothing running on port 3000"

.PHONY: sync-skills
# Keep AI IDE skill copies in sync (source of truth: .cursor/skills)
# Targets: GitHub Copilot, Amazon Kiro, Claude Code, Agents Skills, CodeBuddy
sync-skills:
	@for dest in .github/skills .kiro/skills .claude/skills .agents/skills .codebuddy/skills; do \
		mkdir -p "$$dest" && rsync -a --delete .cursor/skills/ "$$dest/" && echo "synced -> $$dest"; \
	done
