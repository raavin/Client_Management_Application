authorization do  
  role :admin do  
  has_permission_on [:clients, :services, :waiting_lists, :categories, :messages, :roles, :users, :authorization_rules, :case_notes, :expenditures], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :waiting]  
  has_permission_on [:authorization_rules, :authorization_usages], :to => :read
  end  
    
  role :staff do  
  has_permission_on [:clients, :waiting_lists, :messages, :case_notes, :expenditures], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :graph, :change, :suggest_change]
  has_permission_on [:users], :to => [:index, :show, :update]
  end  
  
  role :accounts do  
  has_permission_on [:clients, :messages, :expenditures], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  has_permission_on [:users], :to => [:index, :show, :update]
  end 
  
  role :supervisor do
  has_permission_on [:clients, :services, :waiting_lists, :categories, :messages, :roles, :authorization_rules, :case_notes, :expenditures], :to => [:index, :show, :new, :create, :edit, :update, :destroy] 
  end 
  

end