Class {
	#name : #GtClassUpdateForm,
	#superclass : #GtBehaviorUpdateForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtClassUpdateForm class >> onClass: arg1 [
	^ self new onClass: arg1
]

{ #category : #accessing }
GtClassUpdateForm >> commit [
	| tmp1 |
	tmp1 := newClassName asClass.
	self
		removeClassSlots: tmp1;
		defineClass.
	tmp1 := Smalltalk classNamed: self rawClassName.
	self installClassSlotsOn: tmp1.
	^ tmp1
]

{ #category : #accessing }
GtClassUpdateForm >> onClass: arg1 [
	| tmp1 tmp2 tmp4 |
	self
		newClassName: arg1 name;
		superclassName: arg1 superclass name;
		slots: ((arg1 slots select: [ :arg2 | arg2 definingClass = arg1 ]) collect: #name);
		traits: (arg1 traits collect: #name).
	tmp1 := arg1 package name.
	tmp2 := (arg1 package classTagForClass: arg1) name.
	tmp4 := GtPackageAndTagName new.
	tmp4 packageName: tmp1.
	self
		packageAndTagName: (tmp4 tagName: (tmp2 = tmp1 ifTrue: [ '' ] ifFalse: [ tmp2 ]));
		pools: (arg1 sharedPools collect: #name);
		classVars: (arg1 classVarNames collect: #asString);
		classSlots: (arg1 classSide slots collect: #name);
		superSlots: ((arg1 allSlots collect: #name) asSet
					difference: (arg1 slots collect: #name) asSet)
]

{ #category : #accessing }
GtClassUpdateForm >> removeClassSlots: arg1 [
	| tmp1 tmp3 |
	arg1 classSide slots isEmpty ifTrue: [ ^ self ].
	tmp1 := arg1 classSide slots
			collect: [ :arg2 | RBRemoveInstanceVariableChange remove: arg2 name from: arg1 classSide ].
	tmp3 := RBCompositeRefactoryChange new.
	tmp3
		name: 'Remove class slots';
		changes: tmp1.
	tmp3 yourself gtExecuteWithUndo
]
