Class {
	#name : #GtCopyTraitForm,
	#superclass : #Object,
	#instVars : [
		'innerClass',
		'superClassName',
		'onAccept',
		'newClassName',
		'packageAndTag'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Behavior'
}

{ #category : #'instance creation' }
GtCopyTraitForm class >> for: arg1 [
	^ self new for: arg1
]

{ #category : #converting }
GtCopyTraitForm >> asElement [
	^ self asGtMagritteViewModel asElement
]

{ #category : #accessing }
GtCopyTraitForm >> copyTrait [
	| tmp1 |
	tmp1 := Smalltalk classInstaller
			make: [ :arg1 | 
				arg1
					fillFor: innerClass;
					beTrait;
					name: newClassName trim;
					category: (packageAndTag tagName trim
								ifEmpty: [ packageAndTag packageName trim ]
								ifNotEmpty: [ packageAndTag fullName ]) ].
	tmp1 copyAllCategoriesFrom: innerClass.
	tmp1 class copyAllCategoriesFrom: innerClass class.
	^ tmp1
]

{ #category : #accessing }
GtCopyTraitForm >> for: arg1 [
	| tmp2 |
	innerClass := arg1.
	newClassName := arg1 name asString.
	tmp2 := GtPackageAndTagName new.
	tmp2 packageName: arg1 package name.
	packageAndTag := tmp2 tagName: (self treatTag: arg1)
]

{ #category : #accessing }
GtCopyTraitForm >> magritteAcceptAction [
	<magritteActionDescription>
	| tmp2 |
	tmp2 := super magritteAcceptAction.
	tmp2 label: 'Copy'.
	^ tmp2
		onSuccessCallback: (GtMagritteCallback new
				action: [ :arg1 :arg2 :arg3 :arg4 | 
					[ | tmp3 |
					tmp3 := self copyTrait.
					onAccept ifNotNil: [ onAccept value: tmp3 ] ] on: Error do: #debug ])
]

{ #category : #magritte }
GtCopyTraitForm >> nameDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		label: 'Name';
		priority: 1;
		accessor: #newClassName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtStringsCompletionStrategy new
					completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :arg1 | (Smalltalk classNamed: arg1 trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :arg2 | arg2 isEmpty or: [ arg2 first isUppercase ] ]
			labelled: 'First character must be uppercase'.
	^ tmp2
		addCondition: [ :arg3 | arg3 isAllAlphaNumerics ]
		labelled: 'Class name must be alphanumeric'
]

{ #category : #accessing }
GtCopyTraitForm >> newClassName [
	^ newClassName
]

{ #category : #accessing }
GtCopyTraitForm >> newClassName: arg1 [
	newClassName := arg1
]

{ #category : #accessing }
GtCopyTraitForm >> onAccept: arg1 [
	onAccept := arg1
]

{ #category : #accessing }
GtCopyTraitForm >> packageAndTag [
	^ packageAndTag
]

{ #category : #accessing }
GtCopyTraitForm >> packageAndTag: arg1 [
	packageAndTag := arg1
]

{ #category : #magritte }
GtCopyTraitForm >> packageAndTagDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := GtPackageAndTagDescription new.
	tmp2
		label: 'Package';
		priority: 3;
		accessor: #packageAndTag;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
	^ tmp2 beRequired
]

{ #category : #accessing }
GtCopyTraitForm >> treatTag: arg1 [
	| tmp1 tmp2 tmp3 |
	tmp1 := arg1 category.
	tmp2 := arg1 package name.
	tmp3 := (tmp1 beginsWith: tmp2)
			ifTrue: [ tmp1 allButFirst: tmp2 size ]
			ifFalse: [ '' ].
	^ tmp3 trimBoth: [ :arg2 | arg2 = $- or: [ arg2 isSeparator ] ]
]
