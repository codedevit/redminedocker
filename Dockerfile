FROM redmine:5.0.6

# Dados da Aplicação

WORKDIR "/usr/src/redmine/" 

COPY . .

COPY config/database.yml.web config/database.yml

RUN chown redmine:redmine /usr/src/redmine/ -Rf 
RUN /usr/local/bin/bundle install 

# Fuso Horario
#------------------------------------------
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]  
EXPOSE 3000

# Rodar servidor em modo de produção
CMD ["rails", "server", "-b", "0.0.0.0"]