Extension { #name : #GtClassMethodsCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> categoryFilter: arg1 [
	<gtFilterTypes>
	| tmp2 |
	tmp2 := arg1 explicit.
	tmp2
		title: 'Categories';
		priority: 10.
	^ tmp2
		stencil: [ | tmp3 tmp4 |
			tmp3 := class organization categories asSet.
			tmp3 addAll: class class organization categories.
			tmp3 := tmp3 asSortedCollection.
			tmp4 := GtCoderFilterList new.
			tmp4
				matchParent;
				items: tmp3
					title: [ :arg2 | arg2 ]
					action: [ :arg3 | self setFilters: {GtSearchMethodCategoryFilter forCategory: arg3} source: tmp4 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> classSlotFilter: arg1 [
	<gtFilterTypes>
	| tmp2 |
	tmp2 := arg1 explicit.
	tmp2
		title: 'Class Slots';
		priority: 40.
	^ tmp2
		stencil: [ | tmp3 |
			tmp3 := GtCoderFilterList new.
			tmp3
				matchParent;
				items: (class class allInstVarNames sorted: [ :arg2 :arg3 | arg2 < arg3 ])
					title: [ :arg4 | arg4 ]
					action: [ :arg5 | 
						self
							setFilters: {GtSearchClassSlotReferenceFilter
										forClass: self classOrMetaClass class
										andVariable: arg5}
							source: tmp3 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> classVariableFilter: arg1 [
	<gtFilterTypes>
	| tmp2 |
	tmp2 := arg1 explicit.
	tmp2
		title: 'Class Variables';
		priority: 30.
	^ tmp2
		stencil: [ | tmp3 |
			tmp3 := GtCoderFilterList new.
			tmp3
				matchParent;
				items: (class allClassVarNames sorted: [ :arg2 :arg3 | arg2 < arg3 ])
					title: [ :arg4 | arg4 ]
					action: [ :arg5 | 
						self
							setFilters: {GtSearchClassVariableReferenceFilter
										forClass: self classOrMetaClass
										andVariable: arg5}
							source: tmp3 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> codeGeneratorsDropDown: arg1 for: arg2 [
	| tmp2 tmp4 |
	tmp2 := BrHorizontalPane new.
	tmp2 exact: 300 @ 300.
	tmp4 := GtPhlowCompositeView new.
	tmp4 views: (self codeGeneratorsFor: arg2).
	^ tmp2 addChild: (tmp4 asElementDo: [ :arg3 | arg3 matchParent ])
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> filterDropDown: arg1 [
	| tmp2 tmp4 |
	tmp2 := BlElement new.
	tmp2 size: 430 @ 430.
	tmp4 := GtPhlowCompositeView new.
	tmp4 views: self filterTypes.
	^ tmp2 addChild: (tmp4 asElementDo: [ :arg2 | arg2 matchParent ])
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> instanceSlotFilter: arg1 [
	<gtFilterTypes>
	| tmp2 |
	tmp2 := arg1 explicit.
	tmp2
		title: 'Slots';
		priority: 20.
	^ tmp2
		stencil: [ | tmp3 |
			tmp3 := GtCoderFilterList new.
			tmp3
				matchParent;
				items: (class allInstVarNames sorted: [ :arg2 :arg3 | arg2 < arg3 ])
					title: [ :arg4 | arg4 ]
					action: [ :arg5 | 
						self
							setFilters: {GtSearchInstanceSlotReferenceFilter
										forClass: self classOrMetaClass
										andVariable: arg5}
							source: tmp3 ] ]
]
