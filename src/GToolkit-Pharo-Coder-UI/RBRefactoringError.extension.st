Extension { #name : #RBRefactoringError }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoringError >> messageBlock [
	^ [ :arg1 | 
	| tmp1 |
	tmp1 := BrEditor new.
	tmp1
		hMatchParent;
		vFitContent.
	tmp1 editor text: self messageText asRopedText glamorousRegularFontAndSize.
	tmp1 ]
]
