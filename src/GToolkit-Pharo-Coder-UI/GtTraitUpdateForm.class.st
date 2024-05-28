Class {
	#name : #GtTraitUpdateForm,
	#superclass : #GtBehaviorUpdateForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtTraitUpdateForm class >> onTrait: arg1 [
	^ self new onTrait: arg1
]

{ #category : #accessing }
GtTraitUpdateForm >> classVarsDescription [
	^ nil
]

{ #category : #accessing }
GtTraitUpdateForm >> commit [
	| tmp1 tmp3 |
	tmp1 := self commitPackage categoryName.
	tmp3 := newClassName asClass.
	tmp3 classSide slots
		do: [ :arg1 | (RBRemoveInstanceVariableChange remove: arg1 name from: tmp3 classSide) execute ].
	tmp3 := Smalltalk classInstaller
			make: [ :arg2 | 
				arg2
					name: newClassName;
					category: tmp1;
					slots: slots;
					traitComposition: self traitComposition;
					beTrait ].
	self installClassSlotsOn: tmp3.
	^ tmp3
]

{ #category : #accessing }
GtTraitUpdateForm >> onTrait: arg1 [
	| tmp2 |
	self
		newClassName: arg1 name;
		slots: (arg1 slots collect: #name);
		traits: (arg1 traits collect: #name).
	tmp2 := GtPackageAndTagName new.
	tmp2 packageName: arg1 package name.
	self
		packageAndTagName: (tmp2 tagName: (arg1 package classTagForClass: arg1) name);
		classSlots: (arg1 classSide slots collect: #name);
		superSlots: ((arg1 allSlots collect: #name) asSet
					difference: (arg1 slots collect: #name) asSet)
]

{ #category : #accessing }
GtTraitUpdateForm >> poolsDescription [
	^ nil
]

{ #category : #accessing }
GtTraitUpdateForm >> superclassDescription [
	^ nil
]
