DOCTYPE = LDM
DOCNUMBER = 552
DOCNAME = $(DOCTYPE)-$(DOCNUMBER)

export TEXMFHOME = lsst-texmf/texmf

# Version information extracted from git.
GITVERSION := $(shell git log -1 --date=short --pretty=%h)
GITDATE := $(shell git log -1 --date=short --pretty=%ad)
GITSTATUS := $(shell git status --porcelain)
ifneq "$(GITSTATUS)" ""
	GITDIRTY = -dirty
endif

$(DOCNAME)-$(GITVERSION)$(GITDIRTY).pdf: $(DOCNAME).tex meta.tex
	xelatex -jobname=$(DOCNAME)-$(GITVERSION)$(GITDIRTY) $(DOCNAME)
	bibtex $(DOCNAME)-$(GITVERSION)$(GITDIRTY)
	xelatex -jobname=$(DOCNAME)-$(GITVERSION)$(GITDIRTY) $(DOCNAME)
	xelatex -jobname=$(DOCNAME)-$(GITVERSION)$(GITDIRTY) $(DOCNAME)
	xelatex -jobname=$(DOCNAME)-$(GITVERSION)$(GITDIRTY) $(DOCNAME)

.FORCE:

meta.tex: Makefile .FORCE
	rm -f $@
	touch $@
	echo '% GENERATED FILE -- edit this in the Makefile' >>$@
	/bin/echo '\newcommand{\lsstDocType}{$(DOCTYPE)}' >>$@
	/bin/echo '\newcommand{\lsstDocNum}{$(DOCNUMBER)}' >>$@
	/bin/echo '\newcommand{\vcsrevision}{$(GITVERSION)$(GITDIRTY)}' >>$@
	/bin/echo '\newcommand{\vcsdate}{$(GITDATE)}' >>$@
