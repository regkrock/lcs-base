Class {
	#name : #GtRefactoringNotification,
	#superclass : #Notification,
	#category : #'GToolkit-Pharo-Coder-UI-Extract method'
}

{ #category : #accessing }
GtRefactoringNotification >> defaultAction [
	^ true
]

{ #category : #accessing }
GtRefactoringNotification >> messageBlock [
	^ tag
		ifNil: [ [ :arg1 | 
			| tmp1 |
			tmp1 := BrEditor new.
			tmp1
				hMatchParent;
				vFitContent.
			tmp1 editor text: self messageText asRopedText glamorousRegularFontAndSize.
			tmp1 ] ]
		ifNotNil: [ tag ]
]
